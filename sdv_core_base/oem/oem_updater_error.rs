// Copyright 2024 Google LLC

//! Defines OemUpdater errors.

use nix::errno::Errno;
use std::error::Error;
use thiserror::Error;

/// Errors originating from the OemUpdater
#[derive(Error, Debug)]
pub enum OemUpdaterError {
    /// Invalid OemUpdater request
    #[error("Invalid request: {reason} ")]
    InvalidRequestError {
        /// Invalid request reason
        reason: String,
    },

    /// Mounting error
    #[error(
        "Failed to mount: {error} for source path: {source_path} and target path: {target_path}"
    )]
    MountError {
        /// Error
        error: Errno,
        /// Source Path
        source_path: String,
        /// Target Path
        target_path: String,
    },

    /// Invalid Slot
    #[error("Invalid slot name: {slot_name} ")]
    InvalidSlotError {
        /// Invalid slot name
        slot_name: String,
    },

    /// Error while reading a system property
    #[error("Failed to read system property '{property_name}': {source}")]
    PropertyReadError {
        /// Property name
        property_name: String,
        /// Source error
        #[source]
        source: Box<dyn Error>,
    },

    /// Error while writing a system property
    #[error("Failed to write property '{property_name}' to '{value}': {source}")]
    PropertyWriteError {
        /// Property name
        property_name: String,
        /// Value
        value: String,
        /// Source error
        #[source]
        source: Box<dyn Error>,
    },

    /// Undefined system property
    #[error("System property '{property_name}' not defined")]
    PropertyNotDefined {
        /// Proerty name
        property_name: String,
    },
}
