# Copyright 2023 Google LLC
# The common board config for every SDV lunch target for arm64 target.

TARGET_BOARD_PLATFORM := vsoc_arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53

-include device/google/sdv/common/BoardConfig.mk

# The arm64 image dependencies have a different size than x86_64/cf, which
# results into a larger image size than minidroid provides.
BOARD_SUPER_PARTITION_SIZE := 1073741824

BOARD_KERNEL_CMDLINE += androidboot.fstab_name=fstab androidboot.fstab_suffix=sdv

BOARD_SEPOLICY_DIRS += device/google/sdv/common_arm64/sepolicy/vendor/google/
