# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

PRODUCT_PACKAGES += com.google.cf.vulkan.with_hal
PRODUCT_VENDOR_PROPERTIES += ro.vulkan.apex=com.google.cf.vulkan

PRODUCT_SYSTEM_PROPERTIES += ro.sdv.profile=media

$(call soong_config_set,cvd,RELEASE_SM_OPEN_DECLARED_PASSTHROUGH_HAL,$(RELEASE_SM_OPEN_DECLARED_PASSTHROUGH_HAL))
PRODUCT_PACKAGES += com.google.cf.gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator-service.minigbm \
    mapper.minigbm \
    gralloc.minigbm \

# EGL/GLES implementation with virgl backend enabled.
# TODO: b/326956485 - remove when migration to ANGLE+gfxstream is done
PRODUCT_SOONG_NAMESPACES += device/google/sdv/prebuilts
PRODUCT_PACKAGES += libGLES_mesa

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle \

# Audio related dependencies
PRODUCT_PACKAGES += \
    libtinyalsav2 \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_base/init.sdv_media_base.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.sdv_media_base.rc

# In Android, /vendor/etc/ueventd.rc is loaded automatically, but, by default, no other ueventd
# entries. To enable multiple ueventd.rc files, SDV Core's ueventd.rc import all ueventd.rc files
# from /vendor/etc/sdv_core_ueventd/
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_base/ueventd.sdv_media.rc:$(TARGET_COPY_OUT_VENDOR)/etc/sdv_core_ueventd/ueventd.sdv_media.rc
