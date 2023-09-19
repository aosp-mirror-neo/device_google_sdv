# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi varant is the head unit Android OS + SDV components

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

PRODUCT_NAME := sdv_ivi_cf
PRODUCT_DEVICE := vsoc_x86_64_only

# TODO move to common
PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv.agents.rc:system/etc/init/sdv.agents.rc

include device/google/sdv/sdv_core_common/sdv_core_common_packages.mk
