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
# sdv_core_cf is a sample lunch target that implements the SDV Core
# functionality. It includes all the Google-provided samples.
#
# sdv_core_cf is not meant to be extended by OEM targets. Use sdv_core_base
# instead.

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/bootloader.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance1.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance2.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance3.json)

PRODUCT_NAME := sdv_core_cf
PRODUCT_DEVICE := sdv_core_cf

TARGET_BOARD_INFO_FILE ?= device/google/sdv/sdv_core_cf/android-info.txt

# Configuration file overrides
# NOTE: Make sure to set all binary PDK related variables before other files are
#       included (all variables that start with SDV_)!
# Context: In most SDV makefiles, we are taking the content of those SDV variables
#       and adding the current state of them to PRODUCT_PACKAGES and the like.
#       Therefore, any updates to the SDV variables is not reflected in the
#       PRODUCT packages variables.

## SOME/IP broker config
SDV_SOMEIP_BROKER_CONFIG := broker_config.json
PRODUCT_SYSTEM_PROPERTIES += ro.sdv.someip.broker_config=/system/etc/someip/broker_config.json

# On arm64 architectures, init_open_dice runs on early init, consumes and wipes the open-dice
# device. However, on x86, the open-dice device is not available, so init_open_dice reads this
# content from a static sample DICE handover file added for testing and development.
# TODO: b/409316775 - make the open-dice device available on x86 architectures.
#
# The dice_handover_instance[1,2,3] are to enable manual testing of the mesh described in
# vvmconfig.example.
PRODUCT_PACKAGES += \
    sample_dice_handover_file \
    dice_handover_instance1 \
    dice_handover_instance2 \
    dice_handover_instance3
# Adding the modules to the binary PDK as well.
SDV_BASE_SERVICES_PACKAGES += \
    sample_dice_handover_file \
    dice_handover_instance1 \
    dice_handover_instance2 \
    dice_handover_instance3

# The SDV KeyMint must be added to the PDK, because the PDK is tested without the sources in
# system/software_defined_vehicle/ (where the SDV KeyMint is located), so there would be no KeyMint
# added to the device that tests the PDK.
SDV_BASE_SERVICES_PACKAGES += android.sdv.hardware.security.keymint-service.nonsecure

# Define the Soong modules we want to use for our default services
SDV_VEHICLE_POWER_STATE_MANAGER_MODULE := vepsm
SDV_DIAGNOSTICS_AGENT_MODULE := sdv_diagnostics_agent
SDV_SOMEIP_AGENT_MODULES := \
    sdv_someip_stack_agent \
    vsomeip_config.json

# HM Sample configurations
SDV_CORE_SERVICES_SAMPLES_PACKAGES += \
    hm_config_with_someip.textproto \
    hm_config_without_someip.textproto

# tool allowing vosck_local_cid extraction via adb, for multi-vm tracing testlib purposes
SDV_CORE_SERVICES_SAMPLES_PACKAGES += \
    vsock_local_cid

include device/google/sdv/sdv_core_base/sdv_core_base.mk
# Writable partition mount point for SDV OemUpdater.
# Run with:
# cvd create --custom_partition_path="$OUT/oem_ab.img;$OUT/oem_ab.img;$OUT/oem_ab_metadata.img"
include device/google/sdv/sdv_core_base/oem_ab/oem_ab.mk
include device/google/sdv/sdv_core_base/oem_ab/oem_ab_metadata.mk
include device/google/sdv/sdv_cf/sdv_cf.mk

include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_base/sdv_sample_ethernet_setup.mk

include device/google/sdv/vvmtruststore_preprovisioned/vvmtruststore_preprovisioned.mk

ifeq ($(SDV_CORE_PERF_IMAGE), true)
    include device/google/sdv/sdv_core_base/sdv_performance_modules.mk
else ifeq ($(SDV_CORE_TINY_IMAGE), true)
    PRODUCT_PACKAGES += sdv.brand_new_apex.config \
                        com.sdv.google.sample.update_manager.client \

else
    include device/google/sdv/sdv_core_base/sdv_samples_all.mk
endif

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/samples/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/samples/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_cf/sepolicy/system_ext/private
PRODUCT_PRIVATE_SEPOLICY_DIRS += \
    device/google/sdv/sdv_base/sepolicy/samples/product/private \
    device/google/sdv/sdv_core_base/sepolicy/samples/product/private \
    device/google/sdv/sdv_core_cf/sepolicy/product/private

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

# OemUpdater scripts used for initialization.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/oem_partition.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/oem_partition.rc \
    device/google/sdv/sdv_core_cf/recover_oem_partition.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/recover_oem_partition.sh

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
PRODUCT_PACKAGES += android.sdv.hardware.security.keymint-service.nonsecure

# Preprovisioned vvmtruststore content for /etc.
# Used in test environments where properly mounting a vvmtruststore partition is
# not supported.
# Note that such a scheme makes no sense and must not exist in production
# targets.
PRODUCT_PACKAGES += \
    vvmtruststore_instance1_etc_uds_certs \
    vvmtruststore_instance1_etc_uds_pubs \
    vvmtruststore_instance2_etc_uds_certs \
    vvmtruststore_instance2_etc_uds_pubs \
    vvmtruststore_instance3_etc_uds_certs \
    vvmtruststore_instance3_etc_uds_pubs

# This is a mock MACsec HAL implementation with keys embedded in it. Replace it with a vendor
# specific HAL implementation.
PRODUCT_PACKAGES += android.hardware.macsec-service
# wpa_supplicant build with MACsec support
PRODUCT_PACKAGES += wpa_supplicant_macsec
# Configuration file and init for wpa_supplicant with MACsec
PRODUCT_PACKAGES += \
    sdv_wpa_supplicant_macsec.conf \
    sdv_wpa_supplicant_macsec.rc

# Extra debugging tools
PRODUCT_PACKAGES += \
    heapprofd \
    heapprofd_client \

# Add Compliance testing packages if they are available in the checkout.
PRODUCT_PACKAGES += \
    sdv_compliance_packages \

# Sample config for new user creation to use in samples.
TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_core_cf/config.fs

# Contains all the FQINs that sample OEM agents on the product partition can register.
# Using the PRODUCT_COPY_FILES build variable instead of a Soong module to allow different (OEM)
# targets to define different /product/etc/sdv_native_services_names files.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/sdv_product_native_services_names:$(TARGET_COPY_OUT_PRODUCT)/etc/sdv_native_services_names
