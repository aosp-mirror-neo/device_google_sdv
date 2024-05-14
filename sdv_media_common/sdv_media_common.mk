# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Media' device/product/model, AKA "Rapid Boot VM"/RBVM, is an SDV variant
# with audio/video support.
#
# This file contains the architecture-independent parts components.

# Note: EGL libraries are installed to /vendor. Binaries from /system don't
# have the default library search paths set to use libEGL*.so/libGLES*.so from
# vendor partition. Either install the binaries to /vendor by adding vendor:
# true in Android.bp, or for manual tests, run them with:
#   LD_LIBRARY_PATH=/vendor/lib64/egl:/vendor/lib64/hw

# From device/google/cuttlefish/shared/auto/device_vendor.mk
PRODUCT_COPY_FILES += \
    device/google/cuttlefish/shared/config/graphics/init_graphics.vendor.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init_graphics.vendor.rc \

PRODUCT_PACKAGES += com.google.cf.vulkan
PRODUCT_VENDOR_PROPERTIES += ro.vulkan.apex=com.google.cf.vulkan

$(call soong_config_set,cvd,RELEASE_SM_OPEN_DECLARED_PASSTHROUGH_HAL,$(RELEASE_SM_OPEN_DECLARED_PASSTHROUGH_HAL))
PRODUCT_PACKAGES += com.google.cf.gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator-service.minigbm \
    mapper.minigbm \
    gralloc.minigbm \

# EGL/GLES implementation with virgl backend enabled.
# TODO(b/326956485): remove when migration to ANGLE+gfxstream is done
PRODUCT_SOONG_NAMESPACES += device/google/sdv/prebuilts
PRODUCT_PACKAGES += libGLES_mesa

# Audio related dependencies
PRODUCT_PACKAGES += \
    libtinyalsav2 \
    tinyplay2 \
    tinymix2 \

# Sample application that renders to multiple displays.
PRODUCT_PACKAGES += sdv_multi_display_sample_rust

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_common/init.sdv_media.rc:system/etc/init/hw/init.sdv_media.rc \
    device/google/sdv/sdv_media_common/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \

