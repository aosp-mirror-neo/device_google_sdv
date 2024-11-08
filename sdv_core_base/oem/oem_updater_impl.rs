// Copyright 2024 Google LLC

//! Defines the oem updater implementation.

pub mod oem_updater_error;

use crate::oem_updater_error::OemUpdaterError;
use log::error;
use nix::mount::{mount, MsFlags};
use rustutils::system_properties;
use std::fmt;
use std::path::{Path, PathBuf};

use mockall::automock;

const OEM_UPDATE_PATH: &str = "/oem_updates";
const ACTIVE_OEM_SLOT_PROPERTY: &str = "persist.sdv.active_oem_slot";
const CURRENT_OEM_SLOT_PROPERTY: &str = "ro.boot.sdv.current_oem_slot";

/// Oem Updater Implementation
pub struct OemUpdaterImpl {
    system_properties: Box<dyn SystemProperties>,
    mounter: Box<dyn LibcMounter>,
}

impl OemUpdaterImpl {
    /// OemUpdaterImpl constructor
    pub fn new(
        system_properties: Option<Box<dyn SystemProperties>>,
        mounter: Option<Box<dyn LibcMounter>>,
    ) -> Self {
        Self {
            system_properties: system_properties.unwrap_or_else(|| Box::new(OemSystemProperties)),
            mounter: mounter.unwrap_or_else(|| Box::new(LibcMounterImpl)),
        }
    }

    /// Prepare for an oem partition update.
    /// Return a writable path that can be updated.
    pub fn prepare(&self) -> Result<PathBuf, OemUpdaterError> {
        let writable_slot = self.get_current_slot()?.get_other_slot();
        let source_path_str = self.get_block_device_path(writable_slot)?;
        let source_path = Path::new(&source_path_str);
        let target_path = Path::new(OEM_UPDATE_PATH);

        let res = self.mounter.mount(
            source_path,
            target_path,
            "f2fs",
            MsFlags::MS_NOATIME | MsFlags::MS_NOSUID | MsFlags::MS_NODEV | MsFlags::MS_NOEXEC,
        );

        match res {
            Ok(_) => Ok(target_path.to_path_buf()),
            Err(e) => Err(OemUpdaterError::MountError {
                error: e,
                source_path: source_path.to_string_lossy().to_string(),
                target_path: target_path.to_string_lossy().to_string(),
            }),
        }
    }

    /// Activate an oem partition update.
    pub fn activate(&self) -> Result<(), OemUpdaterError> {
        match self.get_current_slot() {
            Ok(current_slot) => self
                .system_properties
                .write(ACTIVE_OEM_SLOT_PROPERTY, &current_slot.get_other_slot().to_string()),
            Err(err) => {
                error!("Error getting current slot: {}", err);
                Err(err)
            }
        }
    }

    /// Commit an oem partition update after verification.
    pub fn commit(&self) -> Result<(), OemUpdaterError> {
        // TODO: implement commit functionality
        Ok(())
    }

    /// Rollback the previous oem partition update.
    pub fn rollback(&self) -> Result<(), OemUpdaterError> {
        // TODO: implement rollback functionality
        Ok(())
    }

    /// Return the active oem partition slot.
    pub fn get_active_slot(&self) -> Result<Slot, OemUpdaterError> {
        let slot = self.system_properties.read(ACTIVE_OEM_SLOT_PROPERTY)?;

        Slot::from_str(&slot)
    }

    /// Return the current oem partition slot.
    pub fn get_current_slot(&self) -> Result<Slot, OemUpdaterError> {
        let slot = self.system_properties.read(CURRENT_OEM_SLOT_PROPERTY)?;

        Slot::from_str(&slot)
    }

    fn get_block_device_path(&self, slot: Slot) -> Result<String, OemUpdaterError> {
        let slot = self
            .system_properties
            .read(&format!("persist.sdv.oem_slot_{}_device", slot.as_str()))?;
        Ok(slot)
    }
}

/// oem partition slot.
#[derive(Clone, Copy, Debug)]
pub enum Slot {
    /// A
    A,
    /// B
    B,
}

impl fmt::Display for Slot {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.as_str())
    }
}

impl Slot {
    fn from_str(slot_name: &str) -> Result<Slot, OemUpdaterError> {
        match slot_name {
            "a" => Ok(Slot::A),
            "b" => Ok(Slot::B),
            &_ => Err(OemUpdaterError::InvalidSlotError { slot_name: slot_name.to_string() }),
        }
    }

    fn get_other_slot(&self) -> Slot {
        match self {
            Slot::A => Slot::B,
            Slot::B => Slot::A,
        }
    }

    fn as_str(&self) -> &'static str {
        match self {
            Slot::A => "a",
            Slot::B => "b",
        }
    }
}

/// Wrapper used to read system properties.
pub trait SystemProperties: Send + Sync {
    /// Read given system property.
    fn read(&self, property_name: &str) -> Result<String, OemUpdaterError>;
    /// Write value to given system property.
    fn write(&self, property_name: &str, value: &str) -> Result<(), OemUpdaterError>;
}

struct OemSystemProperties;

impl SystemProperties for OemSystemProperties {
    fn read(&self, property_name: &str) -> Result<String, OemUpdaterError> {
        let result = system_properties::read(property_name).map_err(|e| {
            error!("Failed to read: {} due to {}", property_name, e);
            OemUpdaterError::PropertyReadError {
                property_name: property_name.to_string(),
                source: Box::new(e),
            }
        });

        match result {
            Ok(Some(value)) => Ok(value),
            Ok(None) => Err(OemUpdaterError::PropertyNotDefined {
                property_name: property_name.to_string(),
            }),
            Err(e) => Err(e),
        }
    }

    fn write(&self, property_name: &str, value: &str) -> Result<(), OemUpdaterError> {
        system_properties::write(property_name, value).map_err(|e| {
            error!("Failed to write {} to {} due to {}", value, property_name, e);
            OemUpdaterError::PropertyWriteError {
                property_name: property_name.to_string(),
                value: value.to_string(),
                source: Box::new(e),
            }
        })
    }
}

/// Wrapper used to mount a partition.
#[automock]
pub trait LibcMounter: Send + Sync {
    /// Mounts the block device specified on the source path on the target path.
    fn mount(
        &self,
        source: &Path,
        target: &Path,
        fstype: &str,
        flags: MsFlags,
    ) -> Result<(), nix::Error>;
}

struct LibcMounterImpl;

impl LibcMounter for LibcMounterImpl {
    fn mount(
        &self,
        source: &Path,
        target: &Path,
        fstype: &str,
        flags: MsFlags,
    ) -> Result<(), nix::Error> {
        mount(Some(source), target, Some(fstype), flags, Some(""))
    }
}
