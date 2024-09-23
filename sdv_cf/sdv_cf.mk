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
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/init.sdv_cf.rc:system/etc/init/init.sdv_cf.rc
# vvmtruststore partition support
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/vvmtruststore.rc:system/etc/init/vvmtruststore.rc

# Cuttlefish specific networking setup
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/ethernet/ethernet.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/ethernet/ethernet.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.ethernet.rc

# BootControl HAL for Cuttlefish
PRODUCT_PACKAGES += com.android.hardware.boot

# on arm64 architectures, init_open_dice runs on early init, consumes and wipes the open-dice
# device. However, on x86 the open-dice device is not available, so init_open_dice reads this
# content from a static sample DICE handover file added for testing and development.
PRODUCT_PACKAGES += \
    init_open_dice_from_file \
    sample_dice_handover_file \
