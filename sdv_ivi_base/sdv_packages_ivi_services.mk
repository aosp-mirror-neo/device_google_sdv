# Copyright 2024 Google LLC
#
# All the packages required to be installed into the SDV_IVI target are placed
# here.
#

# Components in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_PACKAGES += \
    libsdvgatewayclient \
    libsdvgatewayclient_jni \
    libsdvgatewayclient_jni_product \
    libsdvgatewayclient_jni_vendor \
    libsdvgatewaynetworking_jni \
    libvhal_proxy \
    libvhal_proxy_config_loader \
    sdv_gateway \
    sdv_gatewaynetworking_service

# Vehicle HAL is already included in PRODUCT_PACKAGES, but it must also be part of
# SDV_IVI_SERVICES_PACKAGES for inclusion in the PDK binary as well.
ifeq ($(LOCAL_VHAL_PRODUCT_PACKAGE),)
  $(error $$LOCAL_VHAL_PRODUCT_PACKAGE not set)
endif
SDV_IVI_SERVICES_PACKAGES += $(LOCAL_VHAL_PRODUCT_PACKAGE)

# The packages that provide the Android DICE chain for the SDV Mesh. Either init_open_dice or
# init_open_dice_from_file and the associated files.
ifeq ($(SDV_OPEN_DICE_PROVIDER_PACKAGES),)
  $(error $$SDV_OPEN_DICE_PROVIDER_PACKAGES not set)
endif
SDV_IVI_SERVICES_PACKAGES += $(SDV_OPEN_DICE_PROVIDER_PACKAGES)

SDV_IVI_SERVICES_HOST_PACKAGES += \
    vsidl_rc_generator \
    vsidlc \

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_PACKAGES)


PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    vendor/lib64/libsdvgatewayclient_jni

# Include the packagemanagerproxyd service
include packages/services/Car/cpp/packagemanagerproxy/service/products/packagemanagerproxy.mk
