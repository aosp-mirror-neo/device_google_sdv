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

# Sample packages for SDV base components.
#
# They are not included by sdv_base.mk, only by downstream targets.

SDV_BASE_SERVICES_SAMPLES_PACKAGES += \
    sdv_comms_client_rs \
    sdv_comms_dt_probe_rs \
    sdv_comms_performance_rpc_client_rs \
    sdv_comms_sample_rpc_client_rs \
    sdv_comms_sample_rpc_server_rs \
    sdv_dt_publisher_cpp \
    sdv_dt_subscriber_cpp \
    sdv_mw_cluster_server \
    sdv_mw_cluster_client \
    sdv_mw_sunroof_client \
    sdv_mw_tpms_server \
    sdv_mw_tpms_client \
    sdv_provisioning_tool \
    sdv_user_preferences_client_cpp \
    sdv_vsidl_provider_query \
    vvmconfig.example \
    sdv_uds_certs_provisioner_sample \

SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_BASE_SERVICES_SAMPLES_PACKAGES, $(SDV_BASE_SERVICES_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES, $(SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES))
