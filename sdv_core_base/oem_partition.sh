#!/system/bin/sh
# Copyright 2024 Google LLC

# This bash script is utilized by the OemUpdater in the
# event that the persistent system properties have been
# cleared (data partition wiped). In this case, each
# slot will store a metadata file that is incremented
# every time that slot is selected as the active slot.
# Thus, the latest active slot will have the highest
# counter value. This script will set the active and
# current slot properties.

set -e

oem_a_active_slot_path="/data/misc/oem_a/metadata/active_slot"
oem_b_active_slot_path="/data/misc/oem_b/metadata/active_slot"

log_oem_updater_message() {
	message="$1"
	echo "sdv_oem_updater_impl: $message" >>/dev/kmsg
}

is_integer() {
	trimmed_value=$(echo "$1" | xargs)
	case "$trimmed_value" in
	'' | *[!0-9]*) return 1 ;;
	*) return 0 ;;
	esac
}

# Function to read and validate the counter value from a file
read_counter() {
	file_path="$1"

	if [ ! -s "$file_path" ]; then
		log_oem_updater_message "$file_path does not exist or is empty."
		echo "0"
	else
		counter=$(cat "$file_path")
		if ! is_integer "$counter"; then
			log_oem_updater_message "$file_path contains a non-integer value: $counter."
			echo "0"
		else
			echo "$counter"
		fi
	fi
}

is_valid_update_state() {
	case "$1" in
	Ready | Active | Prepare | ActivePreReboot | ActivePostReboot | Commit | RollbackReboot | Rollback) return 0 ;;
	*) return 1 ;;
	esac
}

log_oem_updater_message "Property persist.sdv.active_oem_slot not set, checking alternative."

oem_a_counter=$(read_counter "$oem_a_active_slot_path")
oem_b_counter=$(read_counter "$oem_b_active_slot_path")

if [ "$oem_a_counter" -gt "$oem_b_counter" ]; then
	setprop persist.sdv.active_oem_slot a
	setprop ro.boot.sdv.current_oem_slot a
	update_state_file_path="/data/misc/oem_a/metadata/update_state"
elif [ "$oem_b_counter" -gt "$oem_a_counter" ]; then
	setprop persist.sdv.active_oem_slot b
	setprop ro.boot.sdv.current_oem_slot b
	update_state_file_path="/data/misc/oem_b/metadata/update_state"
else
	# If counters are equal, default to oem_a
	setprop persist.sdv.active_oem_slot a
	setprop ro.boot.sdv.current_oem_slot a
	update_state_file_path="/data/misc/oem_a/metadata/update_state"
fi

# Assume that if persist.sdv.active_oem_slot was null
# that either the OemUpdater has just been initialized
# or that the data partition has been wiped. Thus, also
# update persist.sdv.oem_update_state from file.
log_oem_updater_message "Property persist.sdv.oem_update_state not set, checking alternative."
update_state=$(tr -d '\r\n' < "$update_state_file_path" 2>/dev/null) ||
  log_oem_updater_message "Update state file not found: $update_state_file_path"

if is_valid_update_state "$update_state"; then
  log_oem_updater_message "Setting persist.sdv.oem_update_state to $update_state."
else
  log_oem_updater_message "Invalid update state: $update_state stored in $update_state_file_path"
  update_state="Ready"
fi

setprop persist.sdv.oem_update_state "$update_state"
