# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Media' device/product/model, AKA "Rapid Boot VM"/RBVM, is an SDV variant
# with audio/video support.
#
# sdv_media_cf is a sample lunch target that implements the SDV Media
# functionality. It includes all the Google-provided samples.
#
# sdv_media_cf is not meant to be extended by OEM targets. Use sdv_media_base
# instead.

PRODUCT_NAME := sdv_media_cf
PRODUCT_DEVICE := sdv_media_cf

$(call inherit-product, device/google/sdv/sdv_media_base/sdv_media_base.mk)
$(call inherit-product, device/google/sdv/sdv_core_cf/sdv_core_cf.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media.json)
TARGET_BOARD_INFO_FILE ?= device/google/sdv/sdv_media_cf/android-info.txt

include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_all.mk
include device/google/sdv/sdv_media_base/sdv_samples_media.mk

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_cf/init.sdv_media_cf.rc:system/etc/init/hw/init.sdv_media_cf.rc \

# Cuttlefish v4l2 camera support
PRODUCT_PACKAGES += cuttlefish_v4l2_streamer
PRODUCT_PACKAGES += sdv_draw_camera_rust

# Cuttlefish loopback device based audio mixer
PRODUCT_PACKAGES += sdv_audio_mixer
