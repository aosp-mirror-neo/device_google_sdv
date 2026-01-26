# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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