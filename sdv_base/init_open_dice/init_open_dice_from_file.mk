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

# TODO: b/475411621 - Move this makefile outside of sdv_base.

# WARNING: For testing and development only!
#          Don't include in production targets!

# init_open_dice_from_file is an insecure, testing-only alternative to
# init_open_dice. It is intended for environments where the open-dice driver
# (thus, the /dev/open-dice0 device) is unavailable.
# E.g., x86 or during board bring-up before the device is configured.
# init_open_dice_from_file function loads the DICE handover from a static
# sample file instead of an open-dice device.

# Replaces the "init_open_dice" module with the insecure testing-only
# "init_open_dice_from_file" module.
PRODUCT_PACKAGES := \
  $(filter-out init_open_dice,$(PRODUCT_PACKAGES)) \
  init_open_dice_from_file

# The dice_handover_instance[1,2,3] are to enable manual testing of the example
# mesh described in vvmconfig.example.
PRODUCT_PACKAGES += \
  dice_handover_instance1 \
  dice_handover_instance2 \
  dice_handover_instance3 \
  sample_dice_handover_file
