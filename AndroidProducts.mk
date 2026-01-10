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

# Format of PRODUCT_MAKEFILES:
# <product_name>:<path_to_the_product_makefile>
# If the "<product_name>:" part is omitted, then the product name will be the base file name
# (without dir and the .mk suffix) of the product makefile.
# Where product_name is the product name, appearing, for instance, in the build fingerprint and
# as the ro.product.name Android property.
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/sdv_core_cf/sdv_core_cf.mk \
    $(LOCAL_DIR)/sdv_core_perf_cf/sdv_core_perf_cf.mk \
    $(LOCAL_DIR)/sdv_core_tiny_cf/sdv_core_tiny_cf.mk \
    $(LOCAL_DIR)/sdv_media_cf/sdv_media_cf.mk \
    $(LOCAL_DIR)/sdv_ivi_cf/sdv_ivi_cf.mk

COMMON_LUNCH_CHOICES := \
    sdv_core_cf-trunk_staging-userdebug \
    sdv_core_perf_cf-trunk_staging-userdebug \
    sdv_core_tiny_cf-trunk_staging-userdebug \
    sdv_media_cf-trunk_staging-userdebug \
    sdv_ivi_cf-trunk_staging-userdebug
