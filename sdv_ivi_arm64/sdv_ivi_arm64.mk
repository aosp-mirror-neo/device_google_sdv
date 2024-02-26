# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi varant is the head unit Android OS + SDV components

$(call inherit-product, device/google/trout/aosp_trout_arm64.mk)

PRODUCT_NAME := sdv_ivi_arm64
PRODUCT_DEVICE := trout_arm64

LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@default-sdv-trout-service

include device/google/sdv/sdv_ivi_common/sdv_ivi_common.mk
