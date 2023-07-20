# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

include device/google/sdv/sdv_core_arm64/BoardConfig.mk

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio-gpu.ko
