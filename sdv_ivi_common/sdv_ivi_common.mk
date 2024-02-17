# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'IVI' variant defines the head unit Android OS + SDV components.

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/

# uncomment this to enable SDV Vehicle HAL Proxy
# ENABLE_SDV_VHAL_PROXY := true
ifeq ($(ENABLE_SDV_VHAL_PROXY),true)
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_common/sepolicy/vendor/google/
endif

PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

PRODUCT_PACKAGES += \
    sdv_sample_gateway_service \
    sdv_vhal_proxy_subscriber \
    libsdvgateway \
    libsdvgateway_jni \

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += device/google/sdv/comp_matrix.xml

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    vendor/lib64/libsdvgateway_jni \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv.agents.rc:system/etc/init/sdv.agents.rc

include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk
include device/google/sdv/sdv_core_common/sdv_ethernet_setup.mk
