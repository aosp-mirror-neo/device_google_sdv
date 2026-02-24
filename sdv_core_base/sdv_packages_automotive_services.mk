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

# All the packages from automotive_services/ required to be installed into the target
# or made available to the host are placed here.

# Check whether all optional default services are set to a variant
ifeq ($(SDV_VEHICLE_POWER_STATE_MANAGER_MODULE),)
  $(error $$SDV_VEHICLE_POWER_STATE_MANAGER_MODULE is not set, so no Vehicle Power State Manager will be installed. \
    For a properly working system, make sure that an implementation will be installed!)
endif

ifeq ($(SDV_DIAGNOSTICS_AGENT_MODULE),)
  $(warning $$SDV_DIAGNOSTICS_AGENT_MODULE is not set, so no Diagnostic Agent will be installed. \
    For a properly working system, make sure that an implementation will be installed!)
endif

SDV_AUTOMOTIVE_SERVICES_PACKAGES += \
    sdv_vpm_agent \
    com.android.sdv.diagnostics \
    com.android.sdv.vpm \
    com.android.sdv.vpm.client \
    com.android.sdv.concal \
    com.android.sdv.user_preferences \
    $(SDV_DIAGNOSTICS_AGENT_MODULE) \
    $(SDV_VEHICLE_POWER_STATE_MANAGER_MODULE)

SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES)

$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES))
