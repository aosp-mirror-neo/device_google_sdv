# Copyright 2024 Google LLC

CUSTOM_IMAGE_MOUNT_POINT := oem
CUSTOM_IMAGE_PARTITION_SIZE := 671088640 # 64 MiB, minimum for f2fs
CUSTOM_IMAGE_FILE_SYSTEM_TYPE := f2fs
CUSTOM_IMAGE_DICT_FILE := device/google/sdv/sdv_core_cf/oem/oem_dict.txt
# Set the SELinux labels on the initial files on the partition based on the file_contexts files.
CUSTOM_IMAGE_SELINUX := true

CUSTOM_IMAGE_COPY_FILES += device/google/sdv/sdv_core_cf/oem/hello_oem.txt:hello_oem.txt
