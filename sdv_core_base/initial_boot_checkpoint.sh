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

echo "initial_boot_checkpoint has started successfully"
