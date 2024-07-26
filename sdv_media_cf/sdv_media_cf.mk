# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Media' device/product/model, AKA "Rapid Boot VM"/RBVM, is an SDV variant
# with audio/video support.

PRODUCT_NAME := sdv_media_cf
PRODUCT_DEVICE := sdv_media_cf

$(call inherit-product, device/google/sdv/sdv_media_base/sdv_media_base.mk)
$(call inherit-product, device/google/sdv/sdv_core_cf/sdv_core_cf.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media.json)
TARGET_BOARD_INFO_FILE ?= device/google/sdv/sdv_media_cf/android-info.txt

include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_automotive_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_core_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_platform.mk
include device/google/sdv/sdv_core_base/sdv_samples_telemetry.mk
include device/google/sdv/sdv_media_base/sdv_samples_media.mk

# Cuttlefish v4l2 camera support
PRODUCT_PACKAGES += cuttlefish_v4l2_streamer
PRODUCT_PACKAGES += sdv_draw_camera_rust
