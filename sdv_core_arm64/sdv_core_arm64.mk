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
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_arm64/bootloader.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance1.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance2.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_core_instance3.json)

PRODUCT_NAME := sdv_core_arm64
PRODUCT_DEVICE := sdv_core_arm64

# Configuration file overrides

## SOME/IP broker config
SDV_SOMEIP_BROKER_CONFIG := broker_config.json
PRODUCT_SYSTEM_PROPERTIES += ro.sdv.someip.broker_config=/system/etc/someip/broker_config.json

## VvmConfig
PRODUCT_SDV_VVM_CONFIG := system/software_defined_vehicle/core_services/service_discovery/sdv_sd_agent/configs/vvm_config.textproto

PRODUCT_CHARACTERISTICS := nosdcard,automotive

# For some automotive hypervisors targets, the path of this init file is configured in boot
# command line in VM configs.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_arm64/init.sdv_core_arm64.rc:system/etc/init/hw/init.sdv.rc \

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_arm64/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/sdv/sdv_core_arm64/fstab.sdv:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
PRODUCT_PACKAGES += android.sdv.hardware.security.keymint-service.nonsecure

# The default Boot Control HAL implementation. Required, for example, by the update_verifier.
PRODUCT_PACKAGES += com.android.hardware.boot

SDV_VEHICLE_POWER_STATE_MANAGER_MODULE := vepsm
SDV_DIAGNOSTICS_AGENT_MODULE := sdv_diagnostics_agent

# Sample implementations of the SOME/IP stack and Diagnostics agent
SDV_SOMEIP_AGENT_MODULES := \
    sdv_someip_stack_agent \
    vsomeip_config.json \

# HM Sample configurations
SDV_CORE_SERVICES_SAMPLES_PACKAGES += \
    hm_config_with_someip.textproto \
    hm_config_without_someip.textproto

# tool allowing vosck_local_cid extraction via adb, for multi-vm tracing testlib purposes
SDV_CORE_SERVICES_SAMPLES_PACKAGES += \
    vsock_local_cid

# Performance profiling tool
PRODUCT_PACKAGES += simpleperf

# Contains all the FQINs that sample OEM agents on the product partition can register.
# Using the PRODUCT_COPY_FILES build variable instead of a Soong module to allow different (OEM)
# targets to define different /product/etc/sdv_native_services_names files.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_arm64/sdv_product_native_services_names:$(TARGET_COPY_OUT_PRODUCT)/etc/sdv_native_services_names

include device/google/sdv/sdv_core_base/sdv_core_base.mk
# Writable partition mount point for SDV OemUpdater.
# Run with:
# cvd create --custom_partition_path="$OUT/oem_ab.img;$OUT/oem_ab.img;$OUT/oem_ab_metadata.img"
include device/google/sdv/sdv_core_base/oem_ab/oem_ab.mk
include device/google/sdv/sdv_core_base/oem_ab/oem_ab_metadata.mk
include device/google/sdv/sdv_arm64/sdv_arm64.mk

include device/google/sdv/sdv_core_base/sepolicy/samples/device_sepolicy.mk

include device/google/sdv/sdv_base/sdv_samples_base_services.mk
include device/google/sdv/sdv_base/sdv_sample_ethernet_setup.mk

include device/google/sdv/vvmtruststore_preprovisioned/vvmtruststore_preprovisioned.mk

ifneq ($(SDV_CORE_PERF_IMAGE), true)
    include device/google/sdv/sdv_core_base/sdv_samples_all.mk
else
    include device/google/sdv/sdv_core_base/sdv_performance_modules.mk
endif
