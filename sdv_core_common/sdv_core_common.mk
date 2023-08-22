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

# Networking tools
PRODUCT_PACKAGES += \
    ping \
    ping6 \
    ip \

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

include device/google/sdv/sdv_core_common/sdv_core_common_packages.mk

# Enable tracing on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Set the property for the system partition.
PRODUCT_SYSTEM_PROPERTIES += \
    persist.traced.enable=1
endif

# Perfetto packages for tracing
PRODUCT_PACKAGES_DEBUG += \
    perfetto \
    traced \
    traced_probes \
