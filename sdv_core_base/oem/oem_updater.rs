// Copyright 2024 Google LLC

//! Defines the oem updater interface.

/// TODO: Remove this once the implementation is concrete.
#[allow(dead_code)]
#[derive(Default)]
struct OemUpdater {}

/// TODO: Remove this once the implementation is concrete.
#[allow(dead_code)]
impl OemUpdater {
    /// Prepare for an /oem partition update.
    pub fn prepare() {
        sdv_oem_updater_impl::OemUpdaterImpl::prepare();
    }

    /// Activate an /oem partition update.
    pub fn activate() {
        sdv_oem_updater_impl::OemUpdaterImpl::activate();
    }

    /// Commit an /oem partition update after verification.
    pub fn commit() {
        sdv_oem_updater_impl::OemUpdaterImpl::commit();
    }

    /// Rollback the previous /oem partition update.
    pub fn rollback() {
        sdv_oem_updater_impl::OemUpdaterImpl::rollback();
    }

    /// Return the active /oem partition slot. The slots available are A or B.
    pub fn get_active_slot() -> String {
        sdv_oem_updater_impl::OemUpdaterImpl::get_active_slot()
    }

    /// Return the current /oem partition slot. The slots available are A or B.
    pub fn get_current_slot() -> String {
        sdv_oem_updater_impl::OemUpdaterImpl::get_current_slot()
    }
}
