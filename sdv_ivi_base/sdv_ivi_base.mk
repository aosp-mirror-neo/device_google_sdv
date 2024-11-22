# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'IVI' variant defines the head unit Android OS + SDV components.
#
# sdv_ivi_base defines all the SDV IVI elements. It's intended to be included
# by OEM targets that require SDV IVI functionality.

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/public
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/vendor/google/
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/vendor
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_base/sepolicy/product/private

PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

# TODO: b/328846455 - Migrate to Soong way of adding product compatibility matrix.
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/sdv/sdv_ivi_base/product_comp_matrix.xml

# TODO: b/341159539 - Figure out the correct init order for SDV agents on IVI wrt other
# binaries started at init on IVI.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_base/sdv.agents.rc:system/etc/init/sdv.agents.rc

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.telemetry.metric_config_store_in_mb=10

# Don't use device/google/cuttlefish/shared/auto/auto_ethernet
ENABLE_AUTO_ETHERNET := false

include device/google/sdv/sdv_base/sdv_base.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_services.mk
include device/google/sdv/sdv_ivi_base/sdv_packages_ivi_telemetry.mk
