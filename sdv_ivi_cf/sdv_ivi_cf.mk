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
# The sdv_ivi variant is the head unit Android OS + SDV components
#
# sdv_ivi_cf is not meant to be extended by OEM targets. Use sdv_ivi_base
# instead.

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_ivi_instance1.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_ivi_instance2.json)
$(call soong_config_append,cvd,launch_configs,cvd_config_sdv_ivi_instance3.json)

PRODUCT_NAME := sdv_ivi_cf
PRODUCT_DEVICE := sdv_ivi_cf

LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@V1-sdv-emulator-service

# The SDV KeyMint must be added to the PDK, because the PDK is tested without the sources in
# system/software_defined_vehicle/ (where the SDV KeyMint is located), so the SDV KeyMint won't be
# added to the device that tests the PDK.
SDV_IVI_SERVICES_PACKAGES += com.android.sdv.hardware.keymint.rust_nonsecure

TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_ivi_cf/config.fs

# Define the Soong module with VM level permissions
# This module has to be an APEX with id "com.oem.sdv.authz"
SDV_VM_LEVEL_PERMISSIONS_MODULE := com.oem.sdv.authz.allow_all.ivi

include device/google/sdv/sdv_ivi_base/sdv_ivi_base.mk
include device/google/sdv/sdv_base/sdv_sample_ethernet_setup.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_telemetry.mk
include device/google/sdv/vvmtruststore_preprovisioned/vvmtruststore_preprovisioned.mk
# WARNING: Never use init_open_dice_from_file in production environments.
#          It is used here to be able to test with Cuttlefish on x86.
include device/google/sdv/sdv_base/init_open_dice/init_open_dice_from_file.mk

include device/google/sdv/sdv_ivi_base/sepolicy/samples/device_sepolicy.mk

# Preprovisioned vvmtruststore content for /etc.
# Used in test environments where properly mounting a vvmtruststore partition is
# not supported.
# Note that such a scheme makes no sense and must not exist production targets.
PRODUCT_PACKAGES += \
    vvmtruststore_instance1_etc_uds_certs \
    vvmtruststore_instance1_etc_uds_pubs \
    vvmtruststore_instance2_etc_uds_certs \
    vvmtruststore_instance2_etc_uds_pubs \
    vvmtruststore_instance3_etc_uds_certs \
    vvmtruststore_instance3_etc_uds_pubs

# include ethernet.rc in init.rc file to start on boot for ivi
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet.sdv_ivi_cf.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_ivi_cf/ethernet/ethernet.sdv_ivi_cf.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/ethernet.sdv_ivi_cf.rc
# vvmtruststore mounting logic
PRODUCT_PACKAGES += vvmtruststore.rc

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
PRODUCT_PACKAGES += com.android.sdv.hardware.keymint.rust_nonsecure

# Runtime Resource Overlay for Connectivity service.
PRODUCT_PACKAGES += \
    sdv_ivi_cf_overlay_connectivity
