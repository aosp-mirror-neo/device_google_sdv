# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi variant is the head unit Android OS + SDV components
#
# sdv_ivi_cf is not meant to be extended by OEM targets. Use sdv_ivi_base
# instead.

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

PRODUCT_NAME := sdv_ivi_cf
PRODUCT_DEVICE := sdv_ivi_cf

LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@V1-sdv-emulator-service

# On arm64 architectures, init_open_dice runs on early init, consumes and wipes the open-dice
# device. However, on x86, the open-dice device is not available, so init_open_dice_from_file reads
# this content from a static sample DICE handover file added for testing and development.
# WARNING: init_open_dice_from_file must NOT be added to production targets
SDV_OPEN_DICE_PROVIDER_PACKAGES := \
    init_open_dice_from_file \
    sample_dice_handover_file \

include device/google/sdv/sdv_ivi_base/sdv_ivi_base.mk
include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_telemetry.mk

# include ethernet.rc in init.rc file to start on boot for ivi
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet.sdv_ivi_cf.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/ethernet.sdv_ivi_cf.rc
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/init_open_dice_from_file.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init_open_dice_from_file.rc
# vvmtruststore partition support
PRODUCT_COPY_FILES += device/google/sdv/sdv_cf/vvmtruststore.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/vvmtruststore.rc

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
PRODUCT_PACKAGES += com.android.sdv.hardware.keymint.rust_nonsecure

# Overriding the default KeyMint implementation in Cuttlefish with one that is extended with test
# functionalities for SDV. There's more detail on the APEX selection developer feature at
# https://source.android.com/docs/core/ota/vendor-apex#apex_selection_at_bootup
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.apex.com.android.hardware.keymint=com.android.sdv.hardware.keymint.rust_nonsecure

# The SDV KeyMint must be added to the PDK, because the PDK is tested without the sources in
# system/software_defined_vehicle/ (where the SDV KeyMint is located), so the SDV KeyMint won't be
# added to the device that tests the PDK.
SDV_IVI_SERVICES_PACKAGES += com.android.sdv.hardware.keymint.rust_nonsecure

# Runtime Resource Overlay for Connectivity service.
PRODUCT_PACKAGES += \
    sdv_ivi_cf_overlay_connectivity

# Enable manual testing of the mesh described in vvmconfig.example
PRODUCT_PACKAGES += \
    dice_handover_instance1 \
    dice_handover_instance2 \
    dice_handover_instance3 \
