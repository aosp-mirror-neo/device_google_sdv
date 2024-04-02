# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

PRODUCT_COMPRESSED_APEX := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

PRODUCT_SYSTEM_PROPERTIES += \
    service.adb.listen_addrs=vsock:5555 \

VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.boot_security_patch=$(BOOT_SECURITY_PATCH)

# Disable Treble and the VNDK
PRODUCT_FULL_TREBLE_OVERRIDE := false
PRODUCT_USE_VNDK_OVERRIDE := false
PRODUCT_USE_PRODUCT_VNDK_OVERRIDE := false

PRODUCT_SHIPPING_API_LEVEL := 33

PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_BUILD_VENDOR_IMAGE := true
TARGET_COPY_OUT_VENDOR := vendor

PRODUCT_BRAND := generic

# Stolen from microdroid/Android.bp
PRODUCT_PACKAGES += \
    init_second_stage \
    libbinder \
    libbinder_ndk \
    libstdc++ \
    secilc \
    libadbd_auth \
    libadbd_fs \
    heapprofd_client_api \
    libartpalette-system \
    apexd \
    atrace \
    debuggerd \
    linker \
    servicemanager \
    service \
    tombstoned \
    tombstone_transmit.microdroid \
    cgroups.json \
    task_profiles.json \
    public.libraries.android.txt \
    logcat \
    logd \

# Packages included only for eng or userdebug builds
# su needed for logpersist.* commands
PRODUCT_PACKAGES_DEBUG += \
    logpersist.start \
    su \

# Start logcatd by default and keep up to 30 rotated files around in userdebug/eng builds
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
  logd.logpersistd=logcatd \
  logd.logpersistd.size=30
endif

# Shell and utilities
PRODUCT_PACKAGES += \
    reboot \
    sh \
    strace \
    toolbox \
    toybox \

# Test Binder RPC services
PRODUCT_PACKAGES += \
    minidroid_sd \
    server_minidroid \
    client_minidroid \
    client_minidroid_rust \
    vsock-test

# Additional packages
PRODUCT_PACKAGES += \
    com.android.runtime \
    libc.bootstrap \
    libdl.bootstrap \
    libdl_android.bootstrap \
    libm.bootstrap \
    selinux_policy \
    com.android.adbd \
    mdnsd \

PRODUCT_COPY_FILES += \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.minidroid \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.minidroid \

# FIXME: Hack to get some rootdirs created
PRODUCT_PACKAGES += \
    init.environ.rc

PRODUCT_COPY_FILES += \
    device/google/cuttlefish/shared/minidroid/init.rc:system/etc/init/hw/init.minidroid.rc \
    packages/modules/Virtualization/microdroid/ueventd.rc:vendor/etc/ueventd.rc \
    device/google/cuttlefish/shared/config/seriallogging.rc:vendor/etc/init/seriallogging.rc \

DEVICE_MANIFEST_FILE := \
    device/google/cuttlefish/shared/minidroid/minidroid_vendor_manifest.xml
PRODUCT_PACKAGES += vendor_compatibility_matrix.xml

TARGET_BOARD_INFO_FILE ?= device/google/cuttlefish/shared/minidroid/android-info.txt

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

# vold (VOLume Daemon) and vdc (Volume Daemon Client, vold's command line client) are required for
# file encryption, and User Data Checkpoint
PRODUCT_PACKAGES += vold
PRODUCT_PACKAGES += vdc

include device/google/sdv/sdv_core_common/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_common/sdv_packages_platform.mk
include device/google/sdv/sdv_core_common/sdv_packages_telemetry.mk
include device/google/sdv/sdv_core_common/sdv_ethernet_setup.mk

# Enable tracing and test services on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
  # Traced is the Perfetto system tracing service.
  PRODUCT_SYSTEM_PROPERTIES += persist.traced.enable=1
  # This property sets the tags to a default disabled state.
  # ATrace instrumentation in apps expects the property to always be defined.
  PRODUCT_SYSTEM_PROPERTIES += debug.atrace.tags.enableflags=0
  # Include SDV Test Packages
  -include vendor/google_testing/software_defined_vehicle/build/sdv_packages_test.mk
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
    cmd \
    dumpstate \
    dumpsys \

# Partition debugging utils
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    dmctl \ # device-mapper control

# System update support
PRODUCT_PACKAGES += \
  update_engine \
  update_verifier \
  com.android.os.statsd # TODO: b/328227527 - remove when update_engine can run without statsd

# Utilities for debugging updates
PRODUCT_PACKAGES_DEBUG += \
  update_engine_client \
