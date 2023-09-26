# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi varant is the head unit Android OS + SDV components

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public

# uncomment this to enable SDV Vehicle HAL Proxy
# ENABLE_SDV_VHAL_PROXY := true
ifeq ($(ENABLE_SDV_VHAL_PROXY),true)
LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@V1-sdv-emulator-service
BOARD_SEPOLICY_DIRS += device/google/cuttlefish/shared/auto/sepolicy/vhal
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_ivi_common/sepolicy/vendor/google/
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
endif

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

include device/google/sdv/sdv_ivi_common/sdv_ivi_common.mk
include device/google/sdv/sdv_core_common/sdv_core_common_packages.mk
