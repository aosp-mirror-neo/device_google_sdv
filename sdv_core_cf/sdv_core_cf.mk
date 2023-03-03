#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.
#

$(call inherit-product, device/google/cuttlefish/shared/minidroid/device.mk)
$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/bootloader.mk)

PRODUCT_NAME := sdv_core_cf
PRODUCT_DEVICE := sdv_core_cf
PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/init.rc:system/etc/init/hw/init.sdv.rc \

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \

# SDV proxy application for forwarding the connection between different VMs
PRODUCT_HOST_PACKAGES += sdv_proxy \
    host_deployment_configuration.json \

## SDV Core components (agent, libraries)
# Shared component (utiltites for Core agents and libraries)
PRODUCT_PACKAGES += libsdv_shared
# RPC library
PRODUCT_PACKAGES += libsdvrpc
# Lifecycle manager agent
PRODUCT_PACKAGES += soa_service_lifecycle_manager
# Service discovery library
PRODUCT_PACKAGES += libsdvsd
# Service discovery agent
PRODUCT_PACKAGES += sdv_sd_agent

# SDV deployment configuration
PRODUCT_PACKAGES += deployment_configuration.json \

# SDV Sample applications
PRODUCT_PACKAGES += \
    server_sdv_sample \
    client_sdv_sample \
    com.android.sdv.samples.rpc \
    server_rust_sdv_sample \
    client_rust_sdv_sample \
    logging_sdv_sample \
    structured_logging_sdv_sample \
    compile_time_log_filtering_sdv_sample \
    log_filtering_sdv_sample \
