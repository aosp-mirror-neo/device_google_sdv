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

# SDV Core specific board config shall go into this file.

# Must set these variables before including sdv_core_base/BoardConfig.mk.
TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64

# Set SDV's init .rc script as the primary one which is loaded first by the init process.
# WARNING: the side-effect of specifying this property is that the init .rc files under
# /{system,system_ext,vendor,odm,product}/etc/init/ are no longer imported automatically by the
# init process, and they have to be explicitly imported from the primary init .rc file of SDV.
#
# Only set this if it's not set already. We need to be able to use something else for SDV Media.
LOCAL_ANDROIDBOOT_INIT_RC ?= /system/etc/init/hw/init.sdv_core_cf.rc
# Only set the RPC Network interface name if it's not set already.
SDV_RPC_INTERFACE ?= sdv_rpc

include device/google/sdv/sdv_core_base/BoardConfig.mk

include device/google/sdv/sdv_core_base/sepolicy/samples/board_sepolicy.mk
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_cf/sepolicy/vendor

# SDV OemUpdater block device properties.
BOARD_BOOTCONFIG += \
    androidboot.sdv.oem_slot_a_device=/dev/block/by-name/custom \
    androidboot.sdv.oem_slot_b_device=/dev/block/by-name/custom_1

# Orch->LM binder max parallel calls property
BOARD_BOOTCONFIG += \
    androidboot.sdv.max_bundles_management_threads=12

# HM agent monitoring wait for binder timeout property
BOARD_BOOTCONFIG += \
    androidboot.sdv.health_monitor.agent_startup_timeout_sec=3

# Configuration required for MACsec. See device/google/cuttlefish/shared/BoardConfig.mk.
BOARD_WLAN_DEVICE           := emulator
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_simulated_cf_bp
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HAL_INTERFACE_COMBINATIONS := {{{STA}, 1}, {{AP}, 1}, {{P2P}, 1}}
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_simulated_cf_bp
WPA_SUPPLICANT_VERSION      := VER_0_8_X
WIFI_DRIVER_FW_PATH_PARAM   := "/dev/null"
WIFI_DRIVER_FW_PATH_STA     := "/dev/null"
WIFI_DRIVER_FW_PATH_AP      := "/dev/null"

# The MACsec kernel module
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(SYSTEM_DLKM_SRC)/macsec.ko
