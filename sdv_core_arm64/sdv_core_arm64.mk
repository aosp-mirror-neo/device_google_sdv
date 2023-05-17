# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, device/google/cuttlefish/shared/minidroid/device.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_arm64/bootloader.mk)

PRODUCT_NAME := sdv_core_arm64
PRODUCT_DEVICE := sdv_core_arm64
PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.hardware.type=automotive \
    ro.logd.size=8M \
    persist.adb.tcp.port=5555 \
    ro.debuggable=1

PRODUCT_PACKAGES += \
    dlkm_loader \
    ip \
    tcpdump \
    ping \
    ping6 \

PRODUCT_CHARACTERISTICS := nosdcard,automotive

PRODUCT_COPY_FILES += \
    device/google/sdv/init.sdv.base.rc:system/etc/init/hw/init.sdv.base.rc \
    device/google/sdv/sdv_core_arm64/init.sdv.rc:system/etc/init/hw/init.sdv.rc \

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_arm64/fstab.sdv:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \

TARGET_BOARD_INFO_FILE ?= device/google/sdv/board-info.txt

# SDV proxy application for forwarding the connection between different VMs
PRODUCT_HOST_PACKAGES += sdv_proxy \
    host_deployment_configuration.json \

PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.sh:$(TARGET_COPY_OUT_VENDOR)/bin/ethernet.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.ethernet.rc


## SDV Core components (agent, libraries)
# Shared component (utiltites for Core agents and libraries)
PRODUCT_PACKAGES += libsdv_shared
# RPC library
PRODUCT_PACKAGES += libsdvrpc
# Lifecycle manager agent
PRODUCT_PACKAGES += sdv_lifecycle_agent
# Service discovery library
PRODUCT_PACKAGES += libsdv_sd
# Service discovery agent
PRODUCT_PACKAGES += sdv_sd_agent
# Service discovery CLI utility
PRODUCT_PACKAGES += sdv_sd_cli
# Service Authentication library
PRODUCT_PACKAGES += libsdv_authn

# SDV deployment configuration
PRODUCT_PACKAGES += deployment_configuration.json \

# SDV Sample applications
PRODUCT_PACKAGES += \
    server_sdv_sample \
    client_sdv_sample \
    server_rust_sdv_sample \
    client_rust_sdv_sample \
    server_rust_tokio_sdv_sample \
    client_rust_tokio_sdv_sample \
    com.android.sdv.samples.rpc \
    lifecycle_sample \
    logging_sdv_sample \
    structured_logging_sdv_sample \
    compile_time_log_filtering_sdv_sample \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    com.android.sdv.samples.rochambeau \
    service_authn_sample_rs \
    client_sdv_benchmark_sample \
    sdv_poc \
    sdv_poc_client \
    com.android.sdv.hello.apex \

