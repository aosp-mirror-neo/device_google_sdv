# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.
-include device/google/sdv/common_arm64/BoardConfig.mk
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_mmio.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_dma_buf.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/nd_virtio.ko
BOARD_GENERIC_RAMDISK_KERNEL_MODULES_LOAD := dm-user.ko

HOST_CROSS_OS := linux_bionic
HOST_CROSS_ARCH := arm64
HOST_CROSS_2ND_ARCH :=

BOARD_KERNEL_CMDLINE += androidboot.fstab_name=fstab androidboot.fstab_suffix=sdv
BOARD_BOOTCONFIG += androidboot.init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC)

BOARD_USES_METADATA_PARTITION := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := false

# Disable checks of VBMETA checksums which currently fails for SDV
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
# Put Android into the UNLOCKED state
BOARD_KERNEL_CMDLINE += androidboot.verifiedbootstate=orange

-include device/google/sdv/sdv_core_common/BoardConfig.mk
