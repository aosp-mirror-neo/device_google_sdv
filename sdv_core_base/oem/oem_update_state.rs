// Copyright 2024 Google LLC

//! Defines the oem update state.

use std::sync::Mutex;

use crate::oem_updater_error::OemUpdaterError;

/// TODO(b/378423974): Remove once all variants are used.
#[allow(dead_code)]
#[derive(Debug, PartialEq, Clone)]
pub enum UpdateState {
    Ready,
    Active,
    Prepare,
    ActivePreReboot,
    ActivePostReboot,
    Commit,
    RollbackReboot,
    Rollback,
}

impl UpdateState {
    pub fn validate_transition(&self, next_state: UpdateState) -> Result<(), OemUpdaterError> {
        if matches!(
            (self, next_state.clone()),
            (UpdateState::Ready, UpdateState::Prepare)
                | (UpdateState::Prepare, UpdateState::Active)
                | (UpdateState::Prepare, UpdateState::Rollback)
                | (UpdateState::Active, UpdateState::ActivePreReboot)
                | (UpdateState::Active, UpdateState::Rollback)
                | (UpdateState::ActivePreReboot, UpdateState::ActivePostReboot)
                | (UpdateState::ActivePreReboot, UpdateState::Rollback)
                | (UpdateState::ActivePostReboot, UpdateState::Commit)
                | (UpdateState::ActivePostReboot, UpdateState::RollbackReboot)
                | (UpdateState::RollbackReboot, UpdateState::Ready)
                | (UpdateState::Commit, UpdateState::Ready)
                | (UpdateState::Rollback, UpdateState::Ready)
        ) {
            Ok(())
        } else {
            Err(OemUpdaterError::InvalidRequestError {
                reason: format!("Invalid transition from {:?} to {:?}", self, next_state),
            })
        }
    }
}

pub struct UpdateStatus {
    pub current_state: Mutex<UpdateState>,
}

impl UpdateStatus {
    pub fn new(initial_state: UpdateState) -> Self {
        UpdateStatus { current_state: initial_state.into() }
    }

    pub fn update(&mut self, new_state: UpdateState) -> Result<(), OemUpdaterError> {
        let mut current_state = self.current_state.lock().unwrap();
        current_state.validate_transition(new_state.clone())?;
        *current_state = new_state;
        Ok(())
    }
}
