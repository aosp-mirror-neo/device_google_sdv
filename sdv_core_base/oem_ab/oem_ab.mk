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

BOARD_ROOT_EXTRA_FOLDERS += oem_ab
# /oem_ab_updates is the non active slot during OEM/AB updates.
BOARD_ROOT_EXTRA_FOLDERS += oem_ab_updates

# Makes the oem_ab image installed to the $OUT directory on build and included in the
# sdv_core_*-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += oem_ab

# Must tell the build system where to find the build artifact of the oem_ab image.
ifeq ($(CLANG_COVERAGE),true)
  VARIANT_DIR = android_common_cov
else
  VARIANT_DIR = android_common
endif
BOARD_OEM_AB_IMAGE_LIST := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/sdv_core_base/oem_ab/oem_ab/$(VARIANT_DIR)/oem_ab.img

# The oem_ab partition is owned by the OEM.
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/oem_ab/sepolicy/oem_ab/private
