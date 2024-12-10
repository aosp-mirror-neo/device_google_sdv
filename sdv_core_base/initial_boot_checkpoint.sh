#!/system/bin/sh
# Copyright 2024 Google LLC

# This script is used to handle the case where neither of a system's slots are marked as successful.
# This happens on the `sdv_core_cf` target after starting for the first time with `cvd create`.
# In this scenario, the /data partition is mounted in checkpoint mode. IVold::commitChanges() needs
# to be called to ensure that any data written during this boot is not lost when the system is
# rebooted. Calling this function also marks the current slot as successful, which ensures this
# condition doesn't occur on a following boot.

bootctl="/system/bin/bootctl"

slot0_status=$($bootctl is-slot-marked-successful 0)
slot1_status=$($bootctl is-slot-marked-successful 1)

if [ "$slot0_status" == "0" ] && [ "$slot1_status" == "0" ]; then
  echo "Neither slots were marked as successful. This can happen on the initial boot. \
Committing the checkpoint to ensure the current slot is marked as successful and to \
prevent user data loss."
  /system/bin/vdc checkpoint commitChanges
fi
