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
# The sdv_ivi varant is the head unit Android OS + SDV components

# Specify BT UART device
PRODUCT_VENDOR_PROPERTIES += vendor.ser.bt-uart=/dev/hvc5

# Disable thread network
CF_VENDOR_NO_THREADNETWORK := true

# Disable UWB
CF_VENDOR_NO_UWB := true

# TODO(b/379162284): We may want to try to build this target without GAS package and confirm
#                    whether it influences TLS authentication.
#$(call inherit-product, vendor/auto/embedded/products/google/products/gms.mk)
#$(call inherit-product, vendor/auto/embedded/products/car.mk)
$(call inherit-product, device/google/trout/aosp_trout_arm64.mk)

PRODUCT_NAME := sdv_ivi_arm64
PRODUCT_DEVICE := sdv_ivi_arm64

PRODUCT_COPY_FILES += \
  device/google/sdv/sdv_ivi_arm64/init.sdv_ivi_arm64.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.sdv_ivi_arm64.rc

# TODO(b/379150974): There is another VHAL implementation for SDV,
#                    android.hardware.automotive.vehicle@default-sdv-trout-service, and we need to
#                    confirm which implementation is more suitable for our use case if they are
#                    significantly different.
LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@default-trout-service

PRODUCT_PACKAGES += \
    dlkm_loader \
    tcpdump \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_arm64/ethernet/ethernet.sdv_ivi_arm64.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet.sdv_ivi_arm64.sh \
    device/google/sdv/sdv_ivi_arm64/ethernet/ethernet.sdv_ivi_arm64.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/hw/ethernet.sdv_ivi_arm64.rc

include device/google/sdv/sdv_ivi_base/sdv_ivi_base.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_samples_ivi_telemetry.mk
include device/google/sdv/sdv_base/sdv_sample_ethernet_setup.mk

PRODUCT_CHARACTERISTICS := nosdcard,automotive

include device/google/sdv/sdv_ivi_base/sepolicy/samples/device_sepolicy.mk

# The Rust implementation of the non-secure, pure software KeyMint vendor HAL extended with test
# functionalities for SDV. Among others, the KeyMint HAL provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by the
# Keystore system service.
# This KeyMint implementation of the HAL is only intended to allow testing and policy compliance.
# A real implementation **must implement the TA in a secure environment**, as per CDD 9.11 [C-1-1]:
# "MUST back up the keystore implementation with an isolated execution environment."
#LOCAL_KEYMINT_PRODUCT_PACKAGE := android.sdv.hardware.security.keymint-service.nonsecure
#PRODUCT_PACKAGES += $(LOCAL_KEYMINT_PRODUCT_PACKAGE)

# The default Boot Control HAL implementation. Required, for example, by the update_verifier.
PRODUCT_PACKAGES += com.android.hardware.boot

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
    ro.boot.vendor.apex.com.android.hardware.keymint=com.android.sdv.hardware.keymint.rust_nonsecure

# The SDV KeyMint must be added to the PDK, because the PDK is tested without the sources in
# system/software_defined_vehicle/ (where the SDV KeyMint is located), so the SDV KeyMint won't be
# added to the device that tests the PDK.
SDV_IVI_SERVICES_PACKAGES += com.android.sdv.hardware.keymint.rust_nonsecure

# Runtime Resource Overlay for Connectivity service.
PRODUCT_PACKAGES += sdv_ivi_arm64_overlay_connectivity

# Preprovisioned vvmtruststore content for /system_ext/etc/.
# Used until properly mounting a vvmtruststore partition on arm64 is supported.
# TODO: b/371522021 - configure the vvmtruststore partition on the test hardwares and remove these
#       packages.
PRODUCT_PACKAGES += \
    vvmtruststore_instance1_etc_uds_certs \
    vvmtruststore_instance1_etc_uds_pubs \
    vvmtruststore_instance2_etc_uds_certs \
    vvmtruststore_instance2_etc_uds_pubs \
    vvmtruststore_instance3_etc_uds_certs \
    vvmtruststore_instance3_etc_uds_pubs

PRODUCT_PACKAGES += vvmtruststore.rc

include device/google/sdv/vvmtruststore_preprovisioned/vvmtruststore_preprovisioned.mk

TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_ivi_arm64/config.fs
