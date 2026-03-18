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
# The 'Media' device/product/model, is an SDV variant with audio/video support.

PRODUCT_NAME := sdv_media_arm64
PRODUCT_DEVICE := sdv_media_arm64

$(call inherit-product, device/google/sdv/sdv_media_base/sdv_media_base.mk)
$(call inherit-product, device/google/sdv/sdv_core_arm64/sdv_core_arm64.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media_instance1.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media_instance2.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_media_instance3.json)

include device/google/sdv/sdv_media_base/sdv_samples_media.mk

# For some automotive hypervisors targets, the path of this init file is configured
# in boot command line in VM configs.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_media_arm64/init.sdv_media_arm64.rc:system/etc/init/hw/init.sdv_media.rc \
