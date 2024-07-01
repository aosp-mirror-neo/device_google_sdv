# Copyright 2024 Google LLC
#
# All the packages required to be installed into the SDV_IVI target are placed
# here.
#

# Components in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_PACKAGES = \
    libsdvgateway \
    libsdvgateway_jni \
    libvhal_proxy \
    libvhal_proxy_config_loader \
    libvhal_proxy_proto_cpp \
    android.hardware.automotive.vehicle@V1-sdv-emulator-service

# Samples in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_SAMPLES_PACKAGES = \
    sdv_vhal_proxy_subscriber \

SDV_IVI_SERVICES_HOST_PACKAGES = \
    vsidl_code_generator

SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES =

# TODO(b/321998205): Package the SDV Car Monitor Test App as part of SDV_IVI after
# the grpc-java dependency is removed and/or the library is made apex_available to
# this app. For now, it will need to be installed separately.
#    SdvCarMonitorTestApp \

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_PACKAGES) $(SDV_IVI_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_PACKAGES) $(SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES)


PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    vendor/lib64/libsdvgateway_jni
