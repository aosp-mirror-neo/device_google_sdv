# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.

# Must set these variables before including sdv_core_common/BoardConfig.mk, because they are used in
# minidroid/BoardConfig.mk which is included in sdv_core_common/BoardConfig.mk.
TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64

# Overwrite androidboot.init_rc in minidroid/BoardConfig.mk, and set SDV's init .rc script as the
# primary one which is loaded first by the init process.
# WARNING: the side-effect of specifying this property is that the init .rc files under
# /{system,system_ext,vendor,odm,product}/etc/init/ are no longer imported automatically by the
# init process, and they have to be explicitly imported from the primary init .rc file of SDV.
#
# Only set this if it's not set already. We need to be able to use something else for SDV Media.
LOCAL_ANDROIDBOOT_INIT_RC ?= /system/etc/init/hw/init.sdv.rc

include device/google/sdv/sdv_core_common/BoardConfig.mk

# TODO(b/282720006): Enable file metadata encryption.
BOARD_USES_METADATA_PARTITION := false
