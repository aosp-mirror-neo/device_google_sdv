# Copyright 2023 Google LLC
# The common board config for every SDV lunch target for arm64 target.

TARGET_BOARD_PLATFORM := vsoc_arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53

# Overwrite androidboot.hardware in minidroid's BoardConfig.mk.
LOCAL_ANDROIDBOOT_HARDWARE := sdv

# Overwrite androidboot.init_rc in minidroid's BoardConfig.mk, and set SDV's init .rc script as the
# primary one which is loaded first by the init process.
# WARNING: the side-effect of specifying this property is that the init .rc files under
# /{system,system_ext,vendor,odm,product}/etc/init/ are no longer imported automatically by the
# init process, and they have to be explicitly imported from the primary init .rc file of SDV.
LOCAL_ANDROIDBOOT_INIT_RC := /system/etc/init/hw/init.sdv.rc

# As of now, we inherit the rest of the board config from minidroid.
-include device/google/cuttlefish/shared/minidroid/BoardConfig.mk

# The arm64 image dependencies have a different size than x86_64/cf, which
# results into a larger image size than minidroid provides.
BOARD_SUPER_PARTITION_SIZE := 1073741824

BOARD_KERNEL_CMDLINE += androidboot.fstab_name=fstab androidboot.fstab_suffix=sdv

BOARD_SEPOLICY_DIRS += device/google/sdv/common_arm64/sepolicy/vendor/google/
