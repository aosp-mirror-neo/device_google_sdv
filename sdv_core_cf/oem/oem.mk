# Copyright 2024 Google LLC

CUSTOM_IMAGE_MOUNT_POINT := oem
CUSTOM_IMAGE_PARTITION_SIZE := 67108864 # 64 MiB, minimum for f2fs
CUSTOM_IMAGE_FILE_SYSTEM_TYPE := f2fs
CUSTOM_IMAGE_DICT_FILE := device/google/sdv/sdv_core_cf/oem/oem_dict.txt

CUSTOM_IMAGE_COPY_FILES += device/google/sdv/sdv_core_cf/oem/hello_oem.txt:hello_oem.txt
