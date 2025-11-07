# Copyright 2024 Google LLC
#
# All the packages required to be installed into the SDV_IVI target are placed
# here.
#

# Components in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_PACKAGES += \
    com.sdv.google.gateway.client \
    init_open_dice \
    libsdvgatewayclient \
    libsdvgatewaynetworking_jni \
    libvhal_proxy \
    libvhal_proxy_config_loader \
    sdv_gateway \
    sdv_gatewaynetworking_service

# TODO: b/377688035 - Remove the inclusion of the Communication Stack agents here
# once we have them deployed from an APEX.
SDV_IVI_SERVICES_PACKAGES += \
    dt_agent \
    rpcagent \
    init_open_dice \
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
