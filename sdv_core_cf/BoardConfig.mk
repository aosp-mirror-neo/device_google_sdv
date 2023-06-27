# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.

# Must come before sdv_core_common/BoardConfig.mk, because common_cf/BoardConfig.mk sets
# TARGET_ARCH which is used later by minidroid/BoardConfig.mk within sdv_core_common/BoardConfig.mk.
include device/google/sdv/common_cf/BoardConfig.mk
include device/google/sdv/sdv_core_common/BoardConfig.mk

# TODO(b/282720006): Enable file metadata encryption.
BOARD_USES_METADATA_PARTITION := false
BOARD_USERDATAIMAGE_PARTITION_SIZE := 134217728 # 128 MiB
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true
