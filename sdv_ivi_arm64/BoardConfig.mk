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

# TODO: b/411429498 - Revert the RPC network interface to sdv_rpc.
SDV_RPC_INTERFACE ?= wlan0

include device/google/sdv/sdv_ivi_base/BoardConfig.mk
include device/google/trout/trout_arm64/BoardConfig.mk

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
# TODO: b/341313012 - add open-dice.ko a system kernel module instead
TARGET_KERNEL_VD_MODULES_PATH = kernel/prebuilts/common-modules/virtual-device
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
    $(TARGET_KERNEL_VD_MODULES_PATH)/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)/open-dice.ko

# Add VLAN support.
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko

include device/google/sdv/sdv_ivi_base/sepolicy/samples/board_sepolicy.mk

# Inclusion of ramdisk in board image zip: <product>-img.zip:
BOARD_IMG_USE_RAMDISK = true

# Inclusion of additional artifacts in board image zip: <product>-img.zip:
# Depends on AndroidBoard.mk
BOARD_PACK_RADIOIMAGES += \
    vendor_ramdisk.img \
    vendor-bootconfig.img \
    kernel.img
