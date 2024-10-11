# Copyright 2024 Google LLC
#
# All the packages required to be installed into the SDV_IVI target are placed
# here.
#

# Components in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_PACKAGES = \
    android.hardware.automotive.vehicle@V1-sdv-emulator-service \
    libsdvgatewayclient_jni \
    libsdvgatewayservice \
    libvhal_proxy \
    libvhal_proxy_config_loader \
    libvhal_proxy_config_loader_v2 \
    libvhal_proxy_proto_cpp \
    sdv_gateway

# The packages that provide the Android DICE chain for the SDV Mesh. Either init_open_dice or
# init_open_dice_from_file and the associated files.
ifeq ($(SDV_OPEN_DICE_PROVIDER_PACKAGES),)
  $(error $$SDV_OPEN_DICE_PROVIDER_PACKAGES not set)
endif
SDV_IVI_SERVICES_PACKAGES += $(SDV_OPEN_DICE_PROVIDER_PACKAGES)

SDV_IVI_SERVICES_HOST_PACKAGES = \
    vsidl_code_generator \
    vsidl_rc_generator \
    vsidlc \

# TODO: b/321998205 - Package the SDV Car Monitor Test App as part of SDV_IVI after
# the grpc-java dependency is removed and/or the library is made apex_available to
# this app. For now, it will need to be installed separately.
#    SdvCarMonitorTestApp \

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_PACKAGES)


PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    vendor/lib64/libsdvgatewayclient_jni

# Include the packagemanagerproxyd service
include packages/services/Car/cpp/packagemanagerproxy/service/products/packagemanagerproxy.mk
