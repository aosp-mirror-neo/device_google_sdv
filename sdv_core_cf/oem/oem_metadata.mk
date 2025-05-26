# Copyright 2024 Google LLC

CUSTOM_IMAGE_MOUNT_POINT := oem_metadata
CUSTOM_IMAGE_PARTITION_SIZE := 1048576 # 1 MB
CUSTOM_IMAGE_FILE_SYSTEM_TYPE := ext4
CUSTOM_IMAGE_DICT_FILE := device/google/sdv/sdv_core_cf/oem/oem_metadata_dict.txt
# Set the SELinux labels on the initial files on the partition based on the file_contexts files.
CUSTOM_IMAGE_SELINUX := true
