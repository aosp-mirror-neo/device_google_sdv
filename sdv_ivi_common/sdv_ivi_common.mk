# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'IVI' variant defines the head unit Android OS + SDV components.

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/product/private
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_common/sepolicy/vendor/google/

PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += device/google/sdv/comp_matrix.xml

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv.agents.rc:system/etc/init/sdv.agents.rc

include device/google/sdv/sdv_ivi_common/sdv_packages_ivi_services.mk
# TODO(b/318739373): Remove these and only add the services needed on SDV_IVI for
# SDV-IVI Comms, VHAL Proxy, Telemetry and other components needed on this target.
include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk
include device/google/sdv/sdv_core_common/sdv_ethernet_setup.mk
