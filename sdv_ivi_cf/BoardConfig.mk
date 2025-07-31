# Copyright 2023 Google LLC
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
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/vendor
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_cf/sepolicy/vendor
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/samples/vendor
