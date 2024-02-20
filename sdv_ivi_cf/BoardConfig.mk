# Copyright 2023 Google LLC
# SDV IVI specific board config shall go into this file.

include device/google/cuttlefish/vsoc_x86_64_only/BoardConfig.mk

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko
