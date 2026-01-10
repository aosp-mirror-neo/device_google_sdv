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

# All the samples from platform/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_PLATFORM_SAMPLES_PACKAGES += \
    sdv.brand_new_apex.config

# Warning: This service is not suitable for production targets and should not be used in production
SDV_PLATFORM_SAMPLES_PACKAGES += \
    adbd_auth_service \

SDV_PLATFORM_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_PLATFORM_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_PLATFORM_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_PLATFORM_SAMPLES_PACKAGES, $(SDV_PLATFORM_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_PLATFORM_HOST_SAMPLES_PACKAGES, $(SDV_PLATFORM_HOST_SAMPLES_PACKAGES))
