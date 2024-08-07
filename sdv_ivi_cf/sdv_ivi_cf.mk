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

include device/google/sdv/sdv_ivi_base/sdv_ivi_base.mk
include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_telemetry.mk

# include ethernet.rc in init.rc file to start on boot for ivi
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/ethernet/ethernet.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ethernet.rc
