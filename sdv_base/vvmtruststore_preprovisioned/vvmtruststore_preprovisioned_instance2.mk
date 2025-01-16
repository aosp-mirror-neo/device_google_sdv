# Copyright 2024 Google LLC

# Parameters for the creation of a vvmtrustore writable partition.
#
# This partition is already preprovisioned with data for the SDV VM with
# instance name "instance2" from vvmconfig.example. An SDV VM using this image
# can therefore already be started in SDV Boot Mode LOCKED.
#
# Its purpose is to speed up development and testing, as it saves the developer
# (or the automated test) from performing the factory provisioning flow, which
# is otherwise required before locking an SDV VM.
#
# Consumed by build/make/core/tasks/build_custom_images.mk
CUSTOM_IMAGE_MOUNT_POINT := vvmtruststore
CUSTOM_IMAGE_PARTITION_SIZE := 1048576 # 1 MB
CUSTOM_IMAGE_FILE_SYSTEM_TYPE := ext4

CUSTOM_IMAGE_COPY_FILES := \
  device/google/sdv/sdv_base/vvmtruststore_preprovisioned/instance2/vvmtruststore/uds_pubs:uds_pubs

# TODO: b/379662565 - Remove these files and use a single preprovisioned image
#                     for all SDV VM instances of our sample vvmconfig.example.
CUSTOM_IMAGE_COPY_FILES += \
  device/google/sdv/sdv_base/vvmtruststore_preprovisioned/instance2/vvmtruststore/own_vm_cert:own_vm_cert \
  device/google/sdv/sdv_base/vvmtruststore_preprovisioned/instance2/vvmtruststore/vm_certs:vm_certs \
  device/google/sdv/sdv_base/vvmtruststore_preprovisioned/instance2/vvmtruststore/vm_private:vm_private
