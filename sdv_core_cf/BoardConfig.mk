# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.
include device/google/sdv/common_cf/BoardConfig.mk
include device/google/sdv/sdv_core_common/BoardConfig.mk

# TODO(b/282720006): Enable file metadata encryption.
BOARD_USES_METADATA_PARTITION := false
BOARD_USERDATAIMAGE_PARTITION_SIZE := 67108864
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true
