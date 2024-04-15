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

# TODO(b/320639162): the effect of setting the BOARD_KERNEL_CMDLINE and BOARD_BOOTCONFIG build
# variables depends on the hypervisor. They will work in a cf-based hypervisor, but some automotive
# hypervisors ignore the setting here and configure the command line in their own configuration.
# BOARD_KERNEL_CMDLINE += androidboot.my_boot_property=THIS_MIGHT_NOT_WORK
# BOARD_BOOTCONFIG += androidboot.my_boot_property=THIS_MIGHT_NOT_WORK

# Must set these variables before including sdv_core_common/BoardConfig.mk.
TARGET_BOARD_PLATFORM := vsoc_arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53
include device/google/sdv/sdv_core_common/BoardConfig.mk

# Must come after including sdv_core_common/BoardConfig.mk, because that includes
# minidroid/BoardConfig.mk which resets BOARD_VENDOR_RAMDISK_KERNEL_MODULES.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_mmio.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_dma_buf.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/nd_virtio.ko

# The open-dice driver is a thin layer that passes a memory region specified in the Device Tree
# (DT) to the user space, used for passing the DICE Chain from the bootloader to user space.
# The memory regions in the DT is specified using a reserved-memory node which is tagged for
# open-dice by specifying "google,open-dice" in the `compatible` property. For instance:
#
# reserved-memory {
#   // The number of u32 cells to represent the address of a memory region
#   #address-cells = <2>;
#   // The number of u32 cells to represent the size of a memory region
#   #size-cells = <2>;
#   ranges;
#   // The unit address (after the @) must match the address in the reg property
#   dice@D1C30000 {
#     compatible = "google,open-dice";
#     no-map;
#     // The address and the size of the memory region that is passed to the open-dice driver.
#     // First two hex numbers (cells) represent the address of the memory region, the last two
#     // represent its size.
#     reg = <0x0 0xD1C30000 0x0 0x1000>;
#   };
# };
#
# The open-dice driver exposes the content(s) of the specified memory region(s) as
# /dev/open-dice<n> device(s) (e.g. /dev/open-dice0). See common/drivers/misc/open-dice.c in the
# Linux kernel repository on an example how to use /dev/open-dice0.
#
# See also packages/modules/Virtualization/pvmfw/README.md for an example usage of the open-dice
# driver in the Protected Virtual Machine (pVM) Firmware for Microdroid.
#
# Note that the open-dice driver is only added to the arm64 target, because it relies on the DT
# which is not supported on x86.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/open-dice.ko

BOARD_GENERIC_RAMDISK_KERNEL_MODULES_LOAD := dm-user.ko
