# Copyright 2023 Google LLC
# SDV IVI specific board config shall go into this file.

include device/google/cuttlefish/vsoc_x86_64_only/BoardConfig.mk
include device/google/sdv/sdv_ivi_base/BoardConfig.mk
include device/google/sdv/sdv_cf/BoardConfig.mk

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko
# TODO: b/325133547 - Add this missing module in the CF auto target instead
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/macsec.ko

BOARD_ROOT_EXTRA_FOLDERS := vvmtruststore

# The network interface RPC should use to retrieve its local IP address.
BOARD_BOOTCONFIG += androidboot.sdv.rpc.interface=eth1

# Makes the vvmtruststore image installed to the $OUT directory on build and included in the
# sdv_ivi_cf-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += vvmtruststore

# Must tell the build system where to find the build artifacts of the images.
BOARD_VVMTRUSTSTORE_IMAGE_LIST := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/sdv_base/vvmtruststore/android_common/vvmtruststore.img

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/system_ext/private
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/product/private

# Pre-provisioned vvmstruststore images for ease of testing.

# Makes the image installed to the $OUT directory on build and included in the
# sdv_ivi_cf-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += \
  vvmtruststore_preprovisioned_instance1 \
  vvmtruststore_preprovisioned_instance2 \
  vvmtruststore_preprovisioned_instance3

VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/sdv_base/vvmtruststore_preprovisioned

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE1_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance1/android_common/vvmtruststore_preprovisioned_instance1.img

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE2_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance2/android_common/vvmtruststore_preprovisioned_instance2.img

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE3_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance3/android_common/vvmtruststore_preprovisioned_instance3.img
