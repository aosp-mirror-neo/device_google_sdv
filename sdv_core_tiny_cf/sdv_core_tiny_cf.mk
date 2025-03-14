# Copyright 2025 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# sdv_core_tiny_cf is a lunch target that implements the SDV Core
# functionality and excludes all samples except of update manager
# client sample.

PRODUCT_NAME := sdv_core_tiny_cf
PRODUCT_DEVICE := sdv_core_tiny_cf

SDV_CORE_TINY_IMAGE := true

include device/google/sdv/sdv_core_cf/sdv_core_cf.mk
