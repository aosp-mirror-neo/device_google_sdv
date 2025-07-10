# Copyright 2024 Google LLC
#
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
