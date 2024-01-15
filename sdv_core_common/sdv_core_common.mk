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

# Including this package disables the logic in init which mounts the system partition to /product.
# This logic would cause runtime errors, because the duplicated content of
# /system/etc/vintf/manifest.xml at /product/etc/vintf/manifest.xml.
# TODO(b/305625166): Remove this package once there's a /product partition defined in the fstab.
PRODUCT_PACKAGES += gsi_skip_mount.cfg

# Keystore2 provides cryptographic interfaces for Android services and applications, such as
# instances for security key management. Keystore2 is also required for file encryption, because
# it's used by the vold daemon.
PRODUCT_PACKAGES += keystore2
# Adds the system (Android) framework manifest file (/system/etc/vintf/manifest.xml) which is
# required by keystore2, because keystore2 is on /system, and it contains a vintf_fragment.
# TODO(b/296978905): SDV should not use Android's system manifest, because it contains HALs that SDV
# doesn't provide.
PRODUCT_PACKAGES += system_manifest.xml
# Adds the system (Android) framework compatibility matrices
# (/system/etc/vintf/compatibility_matrix.*.xml) which are required by keystore2.
# TODO(b/296978905): SDV should not use Android's system framework compatibility matrices, because
# it lists HALs that SDV doesn't require from the device (probably, it doesn't cause an issue,
# though, because these HALs are listed as optional).
PRODUCT_PACKAGES += system_compatibility_matrix.xml

include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk

# Enable tracing on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
  # Traced is the Perfetto system tracing service.
  PRODUCT_SYSTEM_PROPERTIES += persist.traced.enable=1
  # This property sets the tags to a default disabled state.
  # ATrace instrumentation in apps expects the property to always be defined.
  PRODUCT_SYSTEM_PROPERTIES += debug.atrace.tags.enableflags=0
endif

# Perfetto packages for tracing
PRODUCT_PACKAGES_DEBUG += \
    perfetto \
    traced \
    traced_probes \

# Support for adb bugreport
PRODUCT_PACKAGES += \
    bugreport \
    bugreportz \
    dumpstate \
    dumpsys \
