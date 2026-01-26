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
# sdv_core_tiny_cf is a lunch target that implements the SDV Core
# functionality and excludes all samples except of update manager
# client sample.

PRODUCT_NAME := sdv_core_tiny_cf
PRODUCT_DEVICE := sdv_core_tiny_cf

SDV_CORE_TINY_IMAGE := true

include device/google/sdv/sdv_core_cf/sdv_core_cf.mk
