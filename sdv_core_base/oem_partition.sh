#!/system/bin/sh
# Copyright 2024 Google LLC

# This bash script is utilized by the OemUpdater in the event that the persistent system properties
# have been cleared (data partition wiped). In this case, each slot will store a metadata file that
# is incremented every time that slot is selected as the active slot. Thus, the latest active slot
# will have the highest counter value. This script will set the active and current slot properties.

set -e

oem_a_file_path="/data/misc/oem_a/metadata"
oem_b_file_path="/data/misc/oem_b/metadata"

is_integer() {
  trimmed_value=$(echo "$1" | xargs)
  case "$trimmed_value" in
    ''|*[!0-9]*) return 1 ;;
    *) return 0 ;;
  esac
}

# Function to read and validate the counter value from a file
read_counter() {
  file_path="$1"

  if [ ! -s "$file_path" ]; then
    echo "sdv_oem_updater_impl: $file_path does not exist or is empty." >> /dev/kmsg
    echo "0"
  else
    counter=$(cat "$file_path")
    if ! is_integer "$counter"; then
      echo "sdv_oem_updater_impl: $file_path contains a non-integer value: $counter" >> /dev/kmsg
      echo "0"
    else
      echo "$counter"
    fi
  fi
}

echo "sdv_oem_updater_impl: Property persist.sdv.active_oem_slot not set, checking alternative " >> /dev/kmsg

oem_a_counter=$(read_counter "$oem_a_file_path")
oem_b_counter=$(read_counter "$oem_b_file_path")

if [ "$oem_a_counter" -gt "$oem_b_counter" ]; then
  setprop persist.sdv.active_oem_slot a
  setprop ro.boot.sdv.current_oem_slot a
elif [ "$oem_b_counter" -gt "$oem_a_counter" ]; then
  setprop persist.sdv.active_oem_slot b
  setprop ro.boot.sdv.current_oem_slot b
else
  # If counters are equal, default to oem_a
  setprop persist.sdv.active_oem_slot a
  setprop ro.boot.sdv.current_oem_slot a
fi
