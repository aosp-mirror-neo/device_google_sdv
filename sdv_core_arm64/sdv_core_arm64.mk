# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_arm64/bootloader.mk)

PRODUCT_NAME := sdv_core_arm64
PRODUCT_DEVICE := sdv_core_arm64

include device/google/sdv/sdv_core_common/sdv_core_common.mk

PRODUCT_PACKAGES += \
    dlkm_loader \
    tcpdump \

# For reading and wiping the open-dice device
PRODUCT_PACKAGES_DEBUG += open-dice-device-tool

# init_open_dice runs on early init, consumes and wipes the open-dice device
PRODUCT_PACKAGES += init_open_dice

PRODUCT_CHARACTERISTICS := nosdcard,automotive

PRODUCT_COPY_FILES += \
    device/google/sdv/init.sdv.base.rc:system/etc/init/hw/init.sdv.base.rc \
    device/google/sdv/sdv_core_common/sdv.agents.rc:system/etc/init/sdv.agents.rc \
    device/google/sdv/sdv_core_arm64/init.sdv.rc:system/etc/init/hw/init.sdv.rc \

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_arm64/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/sdv/sdv_core_arm64/fstab.sdv:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \

PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.ethernet.rc
