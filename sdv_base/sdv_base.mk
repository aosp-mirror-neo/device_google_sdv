# Copyright 2024 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# sdv_base defines all the SDV Core elements. It's intended to be included
# by OEM targets that needs to use the SDV communication stack.

include device/google/sdv/sdv_base/sdv_packages_base_services.mk

# TODO: b/343460855 Remove Configurable Publisher from base and move to ivi after RPC support is available
PRODUCT_PACKAGES += sdv_product_compatibility_matrix.xml