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
# The 'IVI' variant defines the head unit Android OS + SDV components.
#
# sdv_ivi_base defines all the SDV IVI elements. It's intended to be included
# by OEM targets that require SDV IVI functionality.

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/private
# The vvmtruststore partition is owned by the framework i.e. system(_ext).
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/vvmtruststore/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/public
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/system_ext/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/product/private
PRODUCT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/product/public

PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

# TODO: b/328846455 - Migrate to Soong way of adding product compatibility matrix.
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/sdv/sdv_ivi_base/product_comp_matrix.xml

# TODO: b/341159539 - Figure out the correct init order for SDV agents on IVI wrt other
# binaries started at init on IVI.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_base/sdv.agents.rc:system/etc/init/sdv.agents.rc \
    device/google/sdv/sdv_ivi_base/sdv_gateway_config.json:vendor/etc/sdv_gateway_config.json

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.telemetry.metric_config_store_in_mb=10

PRODUCT_SYSTEM_PROPERTIES += ro.sdv.profile=ivi

# Don't use device/google/cuttlefish/shared/auto/auto_ethernet
ENABLE_AUTO_ETHERNET := false

TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_ivi_base/config.fs

# Trigger the Java SDV Gateway networking service to start early:
# The system server loads sdv_gatewaynetworking_service_loader_service and
# brings up the SDV Gateway networking service before BOOT_COMPLETED.
DEVICE_PACKAGE_OVERLAYS += device/google/sdv/sdv_ivi_base/device_overlays
PRODUCT_PACKAGES += sdv_gatewaynetworking_service_loader_service
# List services before sdv_gatewaynetworking_service_loader_service to ensure
# that the services dependency is listed first allowing for optimal order in
# the system server classpath. The alternative is to set
# PRODUCT_BROKEN_SUBOPTIMAL_ORDER_OF_SYSTEM_SERVER_JARS to true.
PRODUCT_SYSTEM_SERVER_JARS += \
    services \
    sdv_gatewaynetworking_service_loader_service

# Perfetto packages for tracing
PRODUCT_PACKAGES_DEBUG += \
    perfetto \
    traced \
    traced_probes \
    traced_relay \

# Contains all the local FQINs that SDV agents can register.
# TODO: b/411314604 - DT agent is running within SdvGateway process for now
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_base/sdv_native_services_names:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sdv_native_services_names

include device/google/sdv/sdv_base/sdv_base.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_telemetry.mk
