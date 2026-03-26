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

# All the packages required to be installed into the SDV_IVI target are placed
# here.

# Samples in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_SAMPLES_PACKAGES += \
    com.android.sdv.sample.ivi.service \
    native_sdv_gateway_test_app \
    native_test_app_acl_policy \
    SdvCarMonitorTestApp_product \
    sdv_car_monitor_test_app_acl_policy_product \
    sdv_dt_publisher_cpp_acl_textproto \
    sdv_vhal_proxy_publisher \
    sdv_vhal_proxy_subscriber \
    vhal_service_acl_policy \
    range_remaining_sample_acl_textproto \
    sunroof_server_acl_policy \
    ivi_acl_provider_vendor_acl_textproto \
    ivi_acl_provider_product_acl_textproto \
    ivi_acl_provider_system_acl_textproto \
    ivi_acl_provider_system_ext_acl_textproto \
    ivi_acl_vsidl_provider_agent_textproto \
    rochambeau_player_rs \
    rochambeau_judge_rs \

# Required for tests:
# 1. vm_ivi/sdv/sample/comm_stack_local_perf_test
# 2. vm_ivi/sdv/sample/comm_stack_test
# 3. vm_ivi_core2/sdv/sample/factory_provisioning_test
SDV_IVI_SERVICES_SAMPLES_PACKAGES += \
    sdv_comms_client_rs \
    vvmconfig.example \
    sdv_uds_certs_provisioner_sample \
    sdv_provisioning_tool \

SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_IVI_SERVICES_SAMPLES_PACKAGES, $(SDV_IVI_SERVICES_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES, $(SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES))

# Include the packagemanagerproxyd test client
include packages/services/Car/cpp/packagemanagerproxy/testclient/products/packagemanagerproxy.mk
