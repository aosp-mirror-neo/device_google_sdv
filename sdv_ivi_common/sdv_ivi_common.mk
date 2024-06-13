# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'IVI' variant defines the head unit Android OS + SDV components.

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/product/private
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_common/sepolicy/vendor/google/

PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

# Release Configuration map
PRODUCT_RELEASE_CONFIG_MAPS += $(wildcard build/release/automotive/release_config_map.textproto)
PRODUCT_RELEASE_CONFIG_MAPS += $(wildcard vendor/google_shared/build/release/automotive/release_config_map.textproto)

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += device/google/sdv/comp_matrix.xml

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

# TODO(b/341159539): Figure out the correct init order for SDV agents on IVI wrt other
# binaries started at init on IVI.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_common/sdv.agents.rc:system/etc/init/sdv.agents.rc

include device/google/sdv/sdv_ivi_common/sdv_packages_ivi_services.mk
include device/google/sdv/sdv_ivi_common/sdv_packages_ivi_telemetry.mk
include device/google/sdv/sdv_core_common/sdv_packages_base_services.mk
include device/google/sdv/sdv_core_common/sdv_ethernet_setup.mk
