# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The sdv_ivi varant is the head unit Android OS + SDV components

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64_only/auto/aosp_cf.mk)

PRODUCT_NAME := sdv_ivi_cf
PRODUCT_DEVICE := vsoc_x86_64_only

ifeq ($(ENABLE_SDV_VHAL_PROXY),true)
LOCAL_VHAL_PRODUCT_PACKAGE := android.hardware.automotive.vehicle@V1-sdv-emulator-service
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
endif

include device/google/sdv/sdv_ivi_common/sdv_ivi_common.mk
