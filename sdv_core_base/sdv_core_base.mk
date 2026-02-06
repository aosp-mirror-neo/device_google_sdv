# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.
#
# sdv_core_base defines all the SDV Core elements. It's intended to be included
# by OEM targets that require SDV Core functionality.

PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

PRODUCT_COMPRESSED_APEX := false
PRODUCT_SYSTEM_PROPERTIES += apexd.config.brand_new_apex=true
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.boot_security_patch=$(BOOT_SECURITY_PATCH)

# Android V SDK level, matches target-level 202404 in the device manifest.
PRODUCT_SHIPPING_API_LEVEL := 35

PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_BUILD_VENDOR_IMAGE := true
TARGET_COPY_OUT_VENDOR := vendor

# Enable OTA from target file.
PRODUCT_BUILD_GENERIC_OTA_PACKAGE := true

# Defining the SEPolicies of the SDV packages located on the system_ext partition by amending the
# private and public policies of the partition. See system/sepolicy/README.md for more details.
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/public
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/system_ext/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/product/private
PRODUCT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/product/public

# TODO: b/356431569 - This is a quick fix for the missing ro.build. properties. Find a final
# solution for adding them back.
PRODUCT_PACKAGES += \
    odm-build.prop \
    oem-build.prop \
    product-build.prop \
    system-build.prop \
    system_dlkm-build.prop \
    system_ext-build.prop \
    vendor-build.prop \
    vendor_manifest.xml

PRODUCT_PACKAGES += \
    init_second_stage \
    libbinder \
    libbinder_ndk \
    libstdc++ \
    secilc \
    libadbd_auth \
    libadbd_fs \
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

# Adds the system (Android) framework manifest file (/system/etc/vintf/manifest.xml) which is
# required by keystore2, because keystore2 is on /system, and it contains a vintf_fragment.
# TODO: b/296978905 - SDV should not use Android's system manifest, because it contains HALs that
#       SDV doesn't provide.
PRODUCT_PACKAGES += system_manifest.xml
PRODUCT_PACKAGES += \
    system_ext_manifest.xml \
    product_manifest.xml

DEVICE_MANIFEST_FILE := device/google/sdv/sdv_core_base/sdv_vendor_manifest.xml

# TODO: b/353711829 - Move this to a system_ext compatibility matrix not a system one, because
#       it only contains the requirements for the ISomeIpStack which is a dependency of the
#       system_ext installed SOME/IP broker
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    device/google/sdv/sdv_base/device_system_compatibility_matrix.xml

# Adds the system (Android) framework compatibility matrices
# (/system/etc/vintf/compatibility_matrix.*.xml) which are required by keystore2.
# TODO: b/296978905 - SDV should not use Android's system framework compatibility matrices, because
#       it lists HALs that SDV doesn't require from the device (probably, it doesn't cause an
#       issue, though, because these HALs are listed as optional).
PRODUCT_PACKAGES += system_compatibility_matrix.xml
PRODUCT_PACKAGES += \
    system_ext_compatibility_matrix.xml \
    product_compatibility_matrix.xml \
    vendor_compatibility_matrix.xml

# Generates the <p>/etc/fs_config_dirs and the <p>/etc/fs_config_files binary files for each
# partition.
PRODUCT_PACKAGES += \
    fs_config_dirs \
    fs_config_files

PRODUCT_PACKAGES += \
    group_system_ext \
    group_product \
    group_vendor \
    passwd_system_ext \
    passwd_product \
    passwd_vendor

TARGET_FS_CONFIG_GEN += device/google/sdv/sdv_core_base/config.fs

# Contains all the FQINs that SDV agents on the (system_ext) partition can register.
PRODUCT_PACKAGES += sdv_native_services_names

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

# Additional packages
PRODUCT_PACKAGES += \
    com.android.runtime \
    libc.bootstrap \
    libdl.bootstrap \
    libdl_android.bootstrap \
    libm.bootstrap \
    selinux_policy \
    sanitizer.libraries.txt \
    com.android.adbd \
    mdnsd \

PRODUCT_BUGREPORTS_SYMLINK_TARGET := /data/local/tmp/bugreports
PRODUCT_PACKAGES += \
    init.environ.rc \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_base/init.sdv_core_base.rc:system/etc/init/init.sdv_core_base.rc \
    device/google/sdv/sdv_core_base/sdv.agents.rc:system/etc/init/sdv.agents.rc \
    device/google/sdv/sdv_core_base/ueventd.rc:vendor/etc/ueventd.rc \
    device/google/cuttlefish/shared/config/seriallogging.rc:vendor/etc/init/seriallogging.rc \
    device/google/sdv/sdv_core_base/initial_boot_checkpoint.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/initial_boot_checkpoint.sh \

# TODO: b/408956504 - merge init_open_dice_service.rc into init_open_dice.rc and remove this.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_base/init_open_dice_service.rc:system_ext/etc/init/init_open_dice_service.rc

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.telemetry.metric_config_store_in_mb=10

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.type=automotive \
    ro.logd.size=8M



# The `dalvik.vm.native.bridge` is a Core Android property, which is required
# for CTS SDV native tests. See build/make/target/product/runtime_libart.mk
#
# Native Bridge is a software layer that allows a device with one type of CPU
# architecture (e.g., x86) to run native code (like C/C++ libraries) that was compiled
# for a different CPU architecture (typically ARM).
#
# '0' value indicates that SDV platform does not support a native bridge.
PRODUCT_SYSTEM_PROPERTIES += ro.dalvik.vm.native.bridge?=0

# Properties set to true the first time orch establishes a connection to power and
# vehicle modes (VPM)
# Check property_context for more information about these properties
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    sdv.orchestrator.bootup.power_mode.ready=false \
    sdv.orchestrator.bootup.vehicle_mode.ready=false

# Configure power management.
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    sdv.vpm.platform.timeout_ms=1000 \
    sdv.vpm.platform.retry_interval_ms=100 \
    sdv.vpm.power.state=POWER_OFF_EXIT \

# Networking tools
PRODUCT_PACKAGES += \
    ping \
    ping6 \
    ip \

ifneq ($(NATIVE_COVERAGE_PATHS),)
# Needed by Tradefed code coverage tool: http://shortn/_MzG0a1dEoi
PRODUCT_PACKAGES += awk
endif

# com.android.i18n contains libandroidicu which is (optionally) required by libsqlite and rusqlite.
# TODO: b/289366123 - In order to save space, remove this APEX or parts of it. This APEX consumes
# 37 MB of space, and has parts that are not needed by the Android version of SQLite. If the ICU
# functionality is not required in SDV then libsqlite and rusqlite can be built without it.
PRODUCT_PACKAGES += com.android.i18n

# Keystore2 provides cryptographic interfaces for Android services and applications, such as
# instances for security key management. Keystore2 is also required for file encryption, because
# it's used by the vold daemon.
PRODUCT_PACKAGES += keystore2

# vold (VOLume Daemon) and vdc (Volume Daemon Client, vold's command line client) are required for
# file encryption, and User Data Checkpoint
PRODUCT_PACKAGES += vold
PRODUCT_PACKAGES += vdc

include device/google/sdv/sdv_base/sdv_base.mk
include device/google/sdv/sdv_core_base/sdv_packages_automotive_services.mk
include device/google/sdv/sdv_core_base/sdv_packages_core_services.mk
include device/google/sdv/sdv_core_base/sdv_packages_platform.mk
include device/google/sdv/sdv_core_base/sdv_packages_telemetry.mk

# Enable tracing and test services on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
  # This property is required for unified multi-vm Perfetto tracing.
  PRODUCT_SYSTEM_PROPERTIES += ro.traced.hypervisor=true
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
    traced_relay \

# Support for adb bugreport
PRODUCT_PACKAGES += \
    bugreport \
    bugreportz \
    cmd \
    dumpstate \
    dumpsys \

# Partition debugging utils
PRODUCT_PACKAGES_DEBUG += dmctl
# TODO: b/419776968 - stop using bootctl in initial_boot_checkpoint.sh and only include it in
#       DEBUG builds.
PRODUCT_PACKAGES += bootctl

# System update support
PRODUCT_PACKAGES += \
  update_engine_nonetd \
  update_verifier \

# Utilities for debugging updates
PRODUCT_PACKAGES_DEBUG += \
  update_engine_client \
