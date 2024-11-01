# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi variant is the head unit Android OS + SDV components
#
# sdv_ivi_cf is not meant to be extended by OEM targets. Use sdv_ivi_base
# instead.

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

PRODUCT_NAME := sdv_ivi_cf
PRODUCT_DEVICE := sdv_ivi_cf

LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@V1-sdv-emulator-service

# On arm64 architectures, init_open_dice runs on early init, consumes and wipes the open-dice
# device. However, on x86, the open-dice device is not available, so init_open_dice_from_file reads
# this content from a static sample DICE handover file added for testing and development.
# WARNING: init_open_dice_from_file must NOT be added to production targets
SDV_OPEN_DICE_PROVIDER_PACKAGES := \
    init_open_dice_from_file \
    sample_dice_handover_file \

include device/google/sdv/sdv_ivi_base/sdv_ivi_base.mk
include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_telemetry.mk

# include ethernet.rc in init.rc file to start on boot for ivi
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet.sdv_ivi_cf.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/ethernet.sdv_ivi_cf.rc
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/init_open_dice_from_file.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init_open_dice_from_file.rc
# vvmtruststore partition support
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/vvmtruststore.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/vvmtruststore.rc

# Runtime Resource Overlay for Connectivity service.
PRODUCT_PACKAGES += \
    sdv_ivi_cf_overlay_connectivity

# Enable manual testing of the mesh described in vvmconfig.example
PRODUCT_PACKAGES += \
    dice_handover_instance1 \
    dice_handover_instance2 \
    dice_handover_instance3 \
