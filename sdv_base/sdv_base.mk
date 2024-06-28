# Copyright 2024 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# The 'base' Makefile contains the functionality needed by any device
# that needs to use the SDV communication stack.

include device/google/sdv/sdv_base/sdv_packages_base_services.mk

PRODUCT_PACKAGES += sdv_product_compatibility_matrix.xml