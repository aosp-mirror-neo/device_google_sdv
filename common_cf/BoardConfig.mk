# Copyright 2023 Google LLC
# The common board config for every SDV lunch target for Cuttlefish.

TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64

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
