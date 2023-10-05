# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.type=automotive \
    ro.logd.size=8M

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.telemetry.metric_config_store_in_mb=10

BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/

# Networking tools
PRODUCT_PACKAGES += \
    ping \
    ping6 \
    ip \

ifneq ($(NATIVE_COVERAGE_PATHS),)
# Needed by Tradefed code coverage tool: http://shortn/_MzG0a1dEoi
PRODUCT_PACKAGES += awk
endif

# The defaults software Keymint HAL implementation which, among others, provides the
# android.hardware.security.keymint.IRemotelyProvisionedComponent Binder AIDL service required by
# Service Discovery, and other interfaces for encryption key management which are used by Keystore.
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service

# com.android.i18n contains libandroidicu which is (optionally) required by libsqlite and rusqlite.
# TODO(b/289366123): In order to save space, remove this APEX or parts of it. This APEX consumes
# 37 MB of space, and has parts that are not needed by the Android version of SQLite. If the ICU
# functionality is not required in SDV then libsqlite and rusqlite can be built without it.
PRODUCT_PACKAGES += com.android.i18n

include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk

# Enable tracing on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Set the property for the system partition.
PRODUCT_SYSTEM_PROPERTIES += \
    persist.traced.enable=1
endif

dist_dir := $(OUT_DIR)/dist
var_names := SDV_AUTOMOTIVE_SERVICES_PACKAGES SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES SDV_CORE_SERVICES_PACKAGES SDV_CORE_SERVICES_SAMPLE_PACKAGES SDV_CORE_SERVICES_HOST_PACKAGES SDV_PLATFORM_PACKAGES SDV_PLATFORM_SAMPLE_PACKAGES SDV_PLATFORM_HOST_PACKAGES SDV_TELEMETRY_PACKAGES SDV_TELEMETRY_SAMPLE_PACKAGES SDV_TELEMETRY_HOST_PACKAGES

sdv-binary-pdk:
    $(foreach var, $(var_names), $(call dump-words-to-file, $(var), ${dist_dir}/$(var).txt))

# Perfetto packages for tracing
PRODUCT_PACKAGES_DEBUG += \
    perfetto \
    traced \
    traced_probes \
