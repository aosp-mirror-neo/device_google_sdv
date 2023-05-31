# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.
-include device/google/sdv/common_cf/BoardConfig.mk
-include device/google/sdv/sdv_core_common/BoardConfig.mk

BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

TARGET_AVB_SYSTEM_EXT_HASHTREE_ALGORITHM ?= sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm $(TARGET_AVB_SYSTEM_HASHTREE_ALGORITHM)

# Extend the vbmeta_system.img from minidroid (which already contains the hashtree metadata of
# system) with system_ext's hashtree metadata.
BOARD_AVB_VBMETA_SYSTEM += system_ext
# Add system_ext to the super.img from minidroid which already contains system and vendor.
BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_PARTITION_LIST += system_ext
