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

PRODUCT_HOST_PACKAGES += sdv_proxy

PRODUCT_PACKAGES += \
    server_sdv_sample \
    client_sdv_sample \
    client_rust_sdv_sample \

# SDV RPC
PRODUCT_PACKAGES += \
    com.android.sdv.samples.rpc \
    libsdvrpc \
    sdv_sample_rpc_client \
    sdv_sample_rpc_server \

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_core_cf/init.rc:system/etc/init/hw/init.sdv.rc \

# fstab.<name> must match with the value of the androidboot.hardware property.
PRODUCT_COPY_FILES += \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.sdv \
    device/google/cuttlefish/shared/minidroid/fstab.minidroid:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.sdv \
