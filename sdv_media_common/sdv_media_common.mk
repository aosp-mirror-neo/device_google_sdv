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

# From device/google/cuttlefish/shared/device.mk
# Setting this makes other Cuttlefish device_vendor.mk's include Vulkan libs
TARGET_VULKAN_SUPPORT := true

# From device/google/cuttlefish/shared/auto/device_vendor.mk
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/cuttlefish/shared/sepolicy/system_ext/private
$(call inherit-product, device/google/cuttlefish/shared/graphics/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/swiftshader/device_vendor.mk)

# Graphics allocator implementation
PRODUCT_PACKAGES += \
    gralloc.minigbm \

# EGL/GLES implementation with virgl backend enabled.
# TODO(b/326956485): remove when migration to ANGLE+gfxstream is done
PRODUCT_SOONG_NAMESPACES += device/google/sdv/prebuilts
PRODUCT_PACKAGES += libGLES_mesa

# Audio related dependencies
PRODUCT_PACKAGES += \
    libtinyalsav2 \
    tinyplay2 \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_common/init.sdv_media.rc:system/etc/init/hw/init.sdv_media.rc \
    device/google/sdv/sdv_media_common/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \

