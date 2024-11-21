# Copyright 2023 Google LLC
# SDV IVI specific board config shall go into this file.

include device/google/cuttlefish/vsoc_x86_64_only/BoardConfig.mk
include device/google/sdv/sdv_ivi_base/BoardConfig.mk
include device/google/sdv/sdv_cf/BoardConfig.mk

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko

BOARD_ROOT_EXTRA_FOLDERS := vvmtruststore

# "m custom_images" must be called for that image to be created.
PRODUCT_CUSTOM_IMAGE_MAKEFILES += \
  device/google/sdv/sdv_base/vvmtruststore.mk

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/system_ext/private
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/product/private
