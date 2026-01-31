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

# SDV IVI specific board config shall go into this file.

# Only set the RPC Network interface name if it's not set already.
SDV_RPC_INTERFACE ?= sdv_rpc

include device/google/cuttlefish/vsoc_x86_64_only/BoardConfig.mk
include device/google/sdv/sdv_ivi_base/BoardConfig.mk

# Based on the Cuttlefish auto target's android-info.txt.
TARGET_BOARD_INFO_FILE := device/google/sdv/sdv_ivi_cf/android-info.txt

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/system_ext/private
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/product/private
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/samples/product/private
PRODUCT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/samples/product/public
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/vendor
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_cf/sepolicy/vendor
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/samples/vendor
