# Copyright 2023 Google LLC
#
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
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/vendor/google/
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/vendor
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

# Don't use device/google/cuttlefish/shared/auto/auto_ethernet
ENABLE_AUTO_ETHERNET := false

TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_ivi_base/config.fs

# TODO: b/419573239 investigate on how to enable the java_library inside a vendor apex,
# or find an alternative way to have sdvgateway available earlier during boot. The following
# commented lines cause the Java SDV Gateway networking service to start earlier: The system
# server loads sdv_gatewaynetworking_service_loader_service and brings up
# SDV Gateway networking service before BOOT_COMPLETED.
# DEVICE_PACKAGE_OVERLAYS += device/google/sdv/sdv_ivi_base/device_overlays
# PRODUCT_PACKAGES += sdv_gatewaynetworking_service_loader_service
# PRODUCT_SYSTEM_SERVER_JARS += sdv_gatewaynetworking_service_loader_service

include device/google/sdv/sdv_base/sdv_base.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_telemetry.mk
