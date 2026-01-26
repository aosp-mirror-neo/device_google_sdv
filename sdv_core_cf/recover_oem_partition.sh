#!/system/bin/sh
# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This bash script is utilized by the OemUpdater in the
# event that the persistent system properties have been
# cleared (data partition wiped). Retrieve the update
# state and active slot from /oem_metadata. This script
# will set the active and current slot properties.

set -e

active_slot_file_path="/oem_metadata/active_slot"
update_state_file_path="/oem_metadata/update_state"

log_oem_updater_message() {
	message="$1"
	echo "sdv_oem_updater_impl: $message" >>/dev/kmsg
}

is_valid_update_state() {
	case "$1" in
	Ready | Active | Prepare | ActivePreReboot | ActivePostReboot | Commit | RollbackReboot | Rollback) return 0 ;;
	*) return 1 ;;
	esac
}

is_valid_slot() {
    [ "$1" = "a" -o "$1" = "b" ]
}

log_oem_updater_message "Property persist.sdv.active_oem_slot not set, checking alternative."
active_slot=$(tr -d '\r\n' < "$active_slot_file_path" 2>/dev/null) ||
  log_oem_updater_message "Active slot file not found: $active_slot_file_path"

if ! is_valid_slot "$active_slot"; then
  log_oem_updater_message "Invalid active slot: $active_slot stored in $active_slot_file_path"
  active_slot="a"
fi

log_oem_updater_message "Setting persist.sdv.active_oem_slot to $active_slot."
setprop persist.sdv.active_oem_slot "$active_slot"
log_oem_updater_message "Setting ro.sdv.current_oem_slot to $active_slot."
setprop ro.sdv.current_oem_slot "$active_slot"

# Assume that if persist.sdv.active_oem_slot was null
# that either the OemUpdater has just been initialized
# or that the data partition has been wiped. Thus, also
# update persist.sdv.oem_update_state from file.
log_oem_updater_message "Property persist.sdv.oem_update_state not set, checking alternative."
update_state=$(tr -d '\r\n' < "$update_state_file_path" 2>/dev/null) ||
  log_oem_updater_message "Update state file not found: $update_state_file_path"

if ! is_valid_update_state "$update_state"; then
  log_oem_updater_message "Invalid update state: $update_state stored in $update_state_file_path"
  update_state="Ready"
fi

log_oem_updater_message "Setting persist.sdv.oem_update_state to $update_state."
setprop persist.sdv.oem_update_state "$update_state"

log_oem_updater_message "recover_partition has started successfully"
