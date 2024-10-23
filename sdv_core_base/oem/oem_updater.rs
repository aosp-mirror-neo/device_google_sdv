// Copyright 2024 Google LLC

//! Defines the oem updater interface.

use once_cell::sync::OnceCell;

static INSTANCE: OnceCell<OemUpdater> = OnceCell::new();

/// TODO: Remove this once the implementation is concrete.
#[allow(dead_code)]
#[derive(Default)]
pub struct OemUpdater {}

impl OemUpdater {
    /// OemUpdater constructor
    pub fn get_instance() -> &'static Self {
        INSTANCE.get_or_init(|| OemUpdater {})
    }

    /// Prepare for an /oem partition update.
    pub fn prepare(&self) {
        sdv_oem_updater_impl::OemUpdaterImpl::prepare();
    }

    /// Activate an /oem partition update.
    pub fn activate(&self) {
        sdv_oem_updater_impl::OemUpdaterImpl::activate();
    }

    /// Commit an /oem partition update after verification.
    pub fn commit(&self) {
        sdv_oem_updater_impl::OemUpdaterImpl::commit();
    }

    /// Rollback the previous /oem partition update.
    pub fn rollback(&self) {
        sdv_oem_updater_impl::OemUpdaterImpl::rollback();
    }

    /// Return the active /oem partition slot. The slots available are A or B.
    pub fn get_active_slot(&self) -> String {
        sdv_oem_updater_impl::OemUpdaterImpl::get_active_slot()
    }

    /// Return the current /oem partition slot. The slots available are A or B.
    pub fn get_current_slot(&self) -> String {
        sdv_oem_updater_impl::OemUpdaterImpl::get_current_slot()
    }
}
