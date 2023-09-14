# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/shared/minidroid/device.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/bootloader.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv.json)

PRODUCT_NAME := sdv_core_cf
PRODUCT_DEVICE := sdv_core_cf
include device/google/sdv/sdv_core_common/sdv_core_common.mk

TARGET_BOARD_INFO_FILE := device/google/sdv/sdv_core_cf/android-info.txt

PRODUCT_SYSTEM_PROPERTIES += \
    ro.sdv.enable_seriallogging=true \

PRODUCT_COPY_FILES += \
    device/google/sdv/init.sdv.base.rc:system/etc/init/hw/init.sdv.rc \
    device/google/sdv/init.sdv.common.rc:system/etc/init/hw/init.sdv.common.rc

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/sdv/sdv_core_cf/fstab.sdv:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \

PRODUCT_COPY_FILES += device/google/sdv/sdv_core_cf/ethernet/ethernet.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_core_cf/ethernet/ethernet.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.ethernet.rc


# Keystore2 provides cryptographic interfaces for Android services and applications, such as
# instances for security key management. Keystore2 is also required for file encryption, because
# it's used by the vold daemon.
PRODUCT_PACKAGES += keystore2
# Adds the system (Android) framework manifest file (/system/etc/vintf/manifest.xml) which is
# required by keystore2, because keystore2 is on /system, and it contains a vintf_fragment.
# TODO(b/296978905): SDV should not use Android's system manifest, because it contains HALs that SDV
# doesn't provide.
PRODUCT_PACKAGES += system_manifest.xml
# Adds the system (Android) framework compatibility matrices
# (/system/etc/vintf/compatibility_matrix.*.xml) which are required by keystore2.
# TODO(b/296978905): SDV should not use Android's system framework compatibility matrices, because
# it lists HALs that SDV doesn't require from the device (probably, it doesn't cause an issue,
# though, because these HALs are listed as optional).
PRODUCT_PACKAGES += system_compatibility_matrix.xml
