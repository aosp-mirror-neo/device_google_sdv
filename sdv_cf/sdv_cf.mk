# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# sdv_cf defines reusable elements specific to Cuttlefish targets derived from
# SDV Core. It's intended to be included by OEM targets running on Cuttlefish.
#
# Note: it should not be used in IVI targets.

# Start Cuttlefish service that prints logs to virtual serial console.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.sdv.enable_seriallogging=true \

# umbrella init.rc for all Cuttlefish-specific parts
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/init.sdv_cf.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.sdv_cf.rc

# Cuttlefish specific networking setup
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/ethernet/ethernet.sdv_cf.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet.sdv_cf.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/ethernet/ethernet.sdv_cf.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/hw/ethernet.sdv_cf.rc

# vvmtruststore mounting logic
PRODUCT_PACKAGES += vvmtruststore.rc

# BootControl HAL for Cuttlefish
PRODUCT_PACKAGES += com.android.hardware.boot
