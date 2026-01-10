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

# All the samples from automotive_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES += \
    com.sdv.google.sample.diagnostics_update \
    com.sdv.oem.sample.concal \
    com.sdv.oem.sample.diagnostics \
    libdiagnostics_update_sample_catalog_files-vsidl-config.binpb \
    libdiagnostics_update_sample_catalog_files-vsidl-config.binpb-V2 \
    libdiagnostics_v1_sample_catalog_files-vsidl-config.binpb \
    vpm_power_state_client \
    vpm_vehicle_state_client \
    test_vm_health_subscriber \
    com.sdv.oem.user_preferences \
    user_preferences_samples_orch_config \
    diagnostics_provider1_sample_orch_config \
    concal_sample_orch_config \

SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES))
