# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Media' device/product/model, AKA "Rapid Boot VM"/RBVM, is an SDV variant
# with audio/video support.

PRODUCT_NAME := sdv_media_arm64
PRODUCT_DEVICE := sdv_media_arm64

$(call inherit-product, device/google/sdv/sdv_media_common/sdv_media_common.mk)
$(call inherit-product, device/google/sdv/sdv_core_arm64/sdv_core_arm64.mk)

include device/google/sdv/deprecated.mk
