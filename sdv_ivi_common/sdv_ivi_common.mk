# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'IVI' variant defines the head unit Android OS + SDV components.

PRODUCT_PACKAGES += \
    sdv_vhal_proxy_subscriber \

include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk
