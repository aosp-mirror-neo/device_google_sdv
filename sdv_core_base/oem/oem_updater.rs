// Copyright 2024 Google LLC

//! Defines the oem updater interface.

use once_cell::sync::OnceCell;
use sdv_oem_updater_impl::oem_updater_error::OemUpdaterError;
use sdv_oem_updater_impl::{OemUpdaterImpl, Slot};
use std::path::PathBuf;

static INSTANCE: OnceCell<OemUpdater> = OnceCell::new();

/// OemUpdater
pub struct OemUpdater {
    oem_updater_impl: OemUpdaterImpl,
}

impl OemUpdater {
    /// OemUpdater constructor
    pub fn get_instance() -> &'static Self {
        INSTANCE.get_or_init(|| OemUpdater { oem_updater_impl: OemUpdaterImpl::new(None, None) })
    }

    /// Prepare for an /oem partition update.
    pub fn prepare(&self) -> Result<PathBuf, OemUpdaterError> {
        self.oem_updater_impl.prepare()
    }

    /// Activate an /oem partition update.
    pub fn activate(&self) -> Result<(), OemUpdaterError> {
        self.oem_updater_impl.activate()
    }

    /// Commit an /oem partition update after verification.
    pub fn commit(&self) -> Result<(), OemUpdaterError> {
        self.oem_updater_impl.commit()
    }

    /// Rollback the previous /oem partition update.
    pub fn rollback(&self) -> Result<(), OemUpdaterError> {
        self.oem_updater_impl.rollback()
    }

    /// Return the active /oem partition slot.
    pub fn get_active_slot(&self) -> Result<Slot, OemUpdaterError> {
        self.oem_updater_impl.get_active_slot()
    }

    /// Return the current /oem partition slot.
    pub fn get_current_slot(&self) -> Result<Slot, OemUpdaterError> {
        self.oem_updater_impl.get_current_slot()
    }
}
