# Copyright 2023 Google LLC
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

include device/google/sdv/sdv_core_base/BoardConfig.mk
