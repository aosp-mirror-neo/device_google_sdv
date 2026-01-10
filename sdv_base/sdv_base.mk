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
#
# sdv_base defines all the SDV Core elements. It's intended to be included
# by OEM targets that needs to use the SDV communication stack.

# Soong configuration for SDV-devices
include device/google/sdv/sdv_base/soong_config.mk

# SDV-devices release configuration maps
include device/google/sdv/sdv_base/sdv_release_config.mk

include device/google/sdv/sdv_base/sdv_packages_base_services.mk

include device/google/sdv/sdv_base/vvmtruststore/vvmtruststore.mk

# TODO: b/343460855 Remove Configurable Publisher from base and move to ivi after RPC support is available
PRODUCT_PACKAGES += sdv_product_compatibility_matrix.xml

# Declare Comms Stack as stub libraries so that they can be loaded dynamically.
PRODUCT_EXTRA_STUB_LIBRARIES += \
  libsdv_comms_ctx_ffi \
  libsdv_comms_dt_ffi \
  libsdv_comms_id_ffi \
  libsdv_comms_sd_ffi

PRODUCT_COPY_FILES += \
  device/google/sdv/sdv_base/init_open_dice.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init_open_dice.rc \
  device/google/sdv/sdv_base/init_authz_property.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init_authz_property.rc \

# Add linker config so that binaries in the /product partition can load Comms Stack libs.
PRODUCT_PRODUCT_LINKER_CONFIG_FRAGMENTS += device/google/sdv/sdv_base/linker.config.json \

# Add linker config so that binaries in the /vendor partition can load Comms Stack libs.
PRODUCT_VENDOR_LINKER_CONFIG_FRAGMENTS += device/google/sdv/sdv_base/linker.config.json \
