# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi varant is the head unit Android OS + SDV components

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public

$(call inherit-product, device/google/trout/aosp_trout_arm64.mk)

PRODUCT_NAME := sdv_ivi_arm64
PRODUCT_DEVICE := trout_arm64

# TODO move to common
PRODUCT_BRAND := Google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := IVI and Software-Defined Vehicle Core

# TODO hack to alloc sdv binary to be install to system partition
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

include device/google/sdv/sdv_core_common/sdv_core_common_packages.mk
