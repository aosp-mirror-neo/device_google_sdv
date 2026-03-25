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

# Components in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_PACKAGES += \
    com.android.sdv.gateway.client \
    libsdvgatewayclient \
    libsdvgatewaynetworking_jni \
    libvhal_proxy \
    libvhal_proxy_config_loader \
    sdv_empty_vsidl_provider_agent_for_ivi \
    sdv_gateway \
    sdv_gatewaynetworking_service \
    sdv_ivi_rt_service

# Adding the VINTF fragment of the DT agent manually, because data tunnel is part of the gateway
# binary.
# TODO: b/377688035 - Remove the inclusion of the Communication Stack agents here
# once we have them deployed from an APEX.
SDV_IVI_SERVICES_PACKAGES += google.sdv.data_tunnel-service.xml
SDV_IVI_SERVICES_PACKAGES += \
    rpcagent \
    sdv_sd_agent_no_vpm

# Vehicle HAL is already included in PRODUCT_PACKAGES, but it must also be part of
# SDV_IVI_SERVICES_PACKAGES for inclusion in the PDK binary as well.
SDV_IVI_SERVICES_PACKAGES += $(LOCAL_VHAL_PRODUCT_PACKAGE)

SDV_IVI_SERVICES_HOST_PACKAGES += \
    vsidl_rc_generator \
    vsidlc \

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_PACKAGES)

$(call soong_config_set, sdv_config, SDV_IVI_SERVICES_PACKAGES, $(SDV_IVI_SERVICES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_IVI_SERVICES_HOST_PACKAGES, $(SDV_IVI_SERVICES_HOST_PACKAGES))


PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    vendor/lib64/libsdvgatewayclient_jni

# Include the packagemanagerproxyd service
include packages/services/Car/cpp/packagemanagerproxy/service/products/packagemanagerproxy.mk
