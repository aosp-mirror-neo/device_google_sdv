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

PRODUCT_MAKEFILES := \
     $(LOCAL_DIR)/sdv_core_arm64/sdv_core_arm64.mk \
     $(LOCAL_DIR)/sdv_core_cf/sdv_core_cf.mk \
     $(LOCAL_DIR)/sdv_core_perf_cf/sdv_core_perf_cf.mk \
     $(LOCAL_DIR)/sdv_core_tiny_cf/sdv_core_tiny_cf.mk \
     $(LOCAL_DIR)/sdv_ivi_arm64/sdv_ivi_arm64.mk \
     $(LOCAL_DIR)/sdv_ivi_cf/sdv_ivi_cf.mk \
     $(LOCAL_DIR)/sdv_media_arm64/sdv_media_arm64.mk \
     $(LOCAL_DIR)/sdv_media_cf/sdv_media_cf.mk

COMMON_LUNCH_CHOICES := \
     sdv_core_arm64-trunk_staging-userdebug \
     sdv_core_cf-trunk_staging-userdebug \
     sdv_core_perf_cf-trunk_staging-userdebug \
     sdv_core_tiny_cf-trunk_staging-userdebug \
     sdv_ivi_arm64-trunk_staging-userdebug \
     sdv_ivi_cf-trunk_staging-userdebug \
     sdv_media_arm64-trunk_staging-userdebug \
     sdv_media_cf-trunk_staging-userdebug
