// Copyright 2024 Google LLC

//! Defines the oem updater implementation.

use std::fmt;

/// TODO: Remove this once the implementation is concrete.
#[allow(dead_code)]
#[derive(Default)]
pub struct OemUpdaterImpl {}

/// TODO: Remove this once the implementation is concrete.
#[allow(dead_code)]
impl OemUpdaterImpl {
    /// Prepare for an /oem partition update.
    pub fn prepare() {}

    /// Activate an /oem partition update.
    pub fn activate() {}

    /// Commit an /oem partition update after verification.
    pub fn commit() {}

    /// Rollback the previous /oem partition update.
    pub fn rollback() {}

    /// Return the active /oem partition slot.
    pub fn get_active_slot() -> String {
        Slot::A.to_string()
    }

    /// Return the current /oem partition slot.
    pub fn get_current_slot() -> String {
        Slot::A.to_string()
    }
}

/// /oem partition slot.
#[derive(Debug)]
pub enum Slot {
    /// A
    A,
    /// B
    B,
}

impl fmt::Display for Slot {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Slot::A => write!(f, "A"),
            Slot::B => write!(f, "B"),
        }
    }
}
