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

BOARD_ROOT_EXTRA_FOLDERS += vvmtruststore

# Makes the vvmtruststore image installed to the $OUT directory on build and included in the
# sdv_core_*-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += vvmtruststore

# Must tell the build system where to find the build artifact of the vvmtruststore image.
ifeq ($(CLANG_COVERAGE),true)
  VARIANT_DIR = android_common_cov
else
  VARIANT_DIR = android_common
endif
BOARD_VVMTRUSTSTORE_IMAGE_LIST := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/sdv_base/vvmtruststore/vvmtruststore/$(VARIANT_DIR)/vvmtruststore.img

# The vvmtruststore partition is owned by the framework i.e. system(_ext).
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/vvmtruststore/sepolicy/vvmtruststore/private