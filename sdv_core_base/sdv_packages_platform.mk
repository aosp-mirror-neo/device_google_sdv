# Copyright 2023-2024 Google LLC
#
# All the packages from platform/ required to be installed into the target
# or made available to the host are placed here.

SDV_PLATFORM_PACKAGES = \
    deployment_configuration.json \
    libsdvrpc

# SDV proxy application for forwarding the connection between different VMs
SDV_PLATFORM_HOST_PACKAGES = \
    host_deployment_configuration.json \
    sdv_proxy \
    sdv_proxy.zip

PRODUCT_PACKAGES += $(SDV_PLATFORM_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_PLATFORM_HOST_PACKAGES)
