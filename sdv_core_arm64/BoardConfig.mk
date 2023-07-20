# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.

HOST_CROSS_OS := linux_bionic
HOST_CROSS_ARCH := arm64
HOST_CROSS_2ND_ARCH :=

BOARD_USES_METADATA_PARTITION := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := false

# Disable checks of VBMETA checksums which currently fails for SDV
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2

# Put Android into the UNLOCKED state
BOARD_KERNEL_CMDLINE += androidboot.verifiedbootstate=orange
BOARD_KERNEL_CMDLINE += androidboot.fstab_name=fstab androidboot.fstab_suffix=sdv

# Must set these variables before including sdv_core_common/BoardConfig.mk, because they are used in
# minidroid/BoardConfig.mk which is included in sdv_core_common/BoardConfig.mk.
TARGET_BOARD_PLATFORM := vsoc_arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53
include device/google/sdv/sdv_core_common/BoardConfig.mk

# Must overwrite the value of BOARD_SUPER_PARTITION_SIZE set in minidroid/BoardConfig.mk included in
# sdv_core_common/BoardConfig.mk, because the arm64 image dependencies have a different size than
# x86_64/cf, which results in a larger image size than minidroid provides.
BOARD_SUPER_PARTITION_SIZE := 1073741824

# Must come after including sdv_core_common/BoardConfig.mk, because that includes
# minidroid/BoardConfig.mk which resets BOARD_VENDOR_RAMDISK_KERNEL_MODULES.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_mmio.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_dma_buf.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/nd_virtio.ko
BOARD_GENERIC_RAMDISK_KERNEL_MODULES_LOAD := dm-user.ko
