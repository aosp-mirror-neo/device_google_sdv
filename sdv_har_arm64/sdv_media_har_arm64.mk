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

# An SDV Media system with HAR preinstalled.

# Set config for launching HAR on cluster display
# This config does not support harry-prebuilt
# Check USE_PREBUILT_HARRY_APP for more details
HARRY_CONFIG_FILES_LIST := \
        data/assets/sdv/config/harry-camera-config-android.json \
        data/assets/sdv/config/harry-audio-device-config.json \
        data/assets/sdv/config/harry-chimes-config.json \
        data/assets/sdv/config/cluster_display_arm64/harry-config.json \
        data/assets/sdv/config/cluster_display/safety-config.json

# This parameter is expected to be set by sdv_harry.mk
DISPLAY_SAFETY_HOME := packages/services/display_safety/service

# Set Safety Monitor IP
PRODUCT_PRODUCT_PROPERTIES += \
     persist.product.harplatform.safetymonitor = "127.0.0.1"

PRODUCT_SYSTEM_PROPERTIES += \
     persist.product.harplatform.safetymonitor = "127.0.0.1"

# Sets the name of the product.
PRODUCT_NAME := sdv_media_har_arm64

# Sets the device, that selects the BoardConfig.mk in sdv_har_arm64
PRODUCT_DEVICE := sdv_har_arm64

# Set HAR_USE_APEX to false to install Harry without using an APEX
HAR_USE_APEX := true

$(call inherit-product, device/google/sdv/sdv_media_arm64/sdv_media_arm64.mk)
$(call inherit-product, device/google/sdv_display_safety/sdv_harry_common.mk)

# Add v4l2-ctl to examine v4l2 devices.
PRODUCT_PACKAGES += v4l2_ctl
