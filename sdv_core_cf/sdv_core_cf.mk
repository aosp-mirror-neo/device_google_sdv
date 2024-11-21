# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# sdv_core_cf is a sample lunch target that implements the SDV Core
# functionality. It includes all the Google-provided samples.
#
# sdv_core_cf is not meant to be extended by OEM targets. Use sdv_core_base
# instead.

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/bootloader.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv.json)

PRODUCT_NAME := sdv_core_cf
PRODUCT_DEVICE := sdv_core_cf

TARGET_BOARD_INFO_FILE ?= device/google/sdv/sdv_core_cf/android-info.txt

# Configuration file overrides

## SOME/IP broker config
SDV_SOMEIP_BROKER_CONFIG := broker_config.json
PRODUCT_SYSTEM_PROPERTIES += ro.sdv.someip.broker_config=/system/etc/someip/broker_config.json

# On arm64 architectures, init_open_dice runs on early init, consumes and wipes the open-dice
# device. However, on x86, the open-dice device is not available, so init_open_dice_from_file reads
# this content from a static sample DICE handover file added for testing and development.
# WARNING: init_open_dice_from_file must NOT be added to production targets
SDV_OPEN_DICE_PROVIDER_PACKAGES := \
    init_open_dice_from_file \
    sample_dice_handover_file \

include device/google/sdv/sdv_core_base/sdv_core_base.mk
include device/google/sdv/sdv_cf/sdv_cf.mk

include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_automotive_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_core_services.mk
include device/google/sdv/sdv_core_base/sdv_samples_platform.mk
include device/google/sdv/sdv_core_base/sdv_samples_telemetry.mk

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/sdv/sdv_core_cf/fstab.sdv:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \

# Root init.rc. File path must match LOCAL_ANDROIDBOOT_INIT_RC defined in BoardConfig.mk.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/init.sdv_core_cf.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.sdv_core_cf.rc \

# An example test service_bundle_contexts file that sets custom SELiunx domains to specific service
# bundles.
# The service_bundle_contexts is not (yet) part of the standard Android SELinux configuration
# files, so it's kept separately and placed among other policy files.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_base/sepolicy/samples/service_bundle_contexts:$(TARGET_COPY_OUT_PRODUCT)/etc/service_bundle_contexts

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
PRODUCT_PACKAGES += android.sdv.hardware.security.keymint-service.nonsecure

# The SDV KeyMint must be added to the PDK, because the PDK is tested without the sources in
# system/software_defined_vehicle/ (where the SDV KeyMint is located), so there would be no KeyMint
# added to the device that tests the PDK.
SDV_BASE_SERVICES_PACKAGES += android.sdv.hardware.security.keymint-service.nonsecure

# Enable manual testing of the mesh described in vvmconfig.example
PRODUCT_PACKAGES += \
    dice_handover_instance1 \
    dice_handover_instance2 \
    dice_handover_instance3 \

# Sample implementations of the SOME/IP stack and Diagnostics agent
PRODUCT_PACKAGES += \
    sdv_someip_stack_agent \
    vsomeip_config.json \
    sdv_diagnostics_agent \
    update_engine_product_partition_post_install \
    update_engine_system_partition_post_install \
    sample_product_ota_postinstall_data \
    sample_system_ota_postinstall_data \

# Add the sdv_provisioning_tool to enable easy testing of the mesh provisioning
# flows.
PRODUCT_PACKAGES += \
    sdv_provisioning_tool \

# A/B updates post install configuration.
# Post install scripts can be added for other partitions in the same way.
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_product=true \
    POSTINSTALL_PATH_product=bin/update_engine_product_partition_post_install \
    FILESYSTEM_TYPE_product=ext4 \
    POSTINSTALL_OPTIONAL_product=false

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/update_engine_system_partition_post_install \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=false
