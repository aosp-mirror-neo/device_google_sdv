# Copyright 2023-2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the target
# or made available to the host are placed here.
#
# There are four variables to distinguish device samples/packages and host samples/packages.

SDV_PLATFORM_PACKAGES = \
    deployment_configuration.json \
    libsdvrpc

SDV_PLATFORM_SAMPLES_PACKAGES =

# SDV proxy application for forwarding the connection between different VMs
SDV_PLATFORM_HOST_PACKAGES = \
    host_deployment_configuration.json \
    sdv_proxy \
    sdv_proxy.zip

SDV_PLATFORM_HOST_SAMPLES_PACKAGES = \

PRODUCT_PACKAGES += $(SDV_PLATFORM_PACKAGES) $(SDV_PLATFORM_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_PLATFORM_HOST_PACKAGES) $(SDV_PLATFORM_HOST_SAMPLES_PACKAGES)
