# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.

# Must set these variables before including sdv_core_common/BoardConfig.mk, because they are used in
# minidroid/BoardConfig.mk which is included in sdv_core_common/BoardConfig.mk.
TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64
include device/google/sdv/sdv_core_common/BoardConfig.mk

# TODO(b/282720006): Enable file metadata encryption.
BOARD_USES_METADATA_PARTITION := false
