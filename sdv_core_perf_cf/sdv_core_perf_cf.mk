# Copyright 2025 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
#
# sdv_core_perf_cf is a sample lunch target that implements the SDV Core
# functionality and includes extra modules (APEXes with Service Bundles)
# with the goal to emulate OEMs production setup to make our performance
# benchmarks closer to reality.
#
# sdv_core_perf_cf is not meant to be extended by OEM targets. Use sdv_core_base
# instead.

PRODUCT_NAME := sdv_core_perf_cf
PRODUCT_DEVICE := sdv_core_perf_cf

SDV_CORE_PERF_IMAGE := true

include device/google/sdv/sdv_core_cf/sdv_core_cf.mk