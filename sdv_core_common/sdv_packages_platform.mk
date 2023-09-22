# Copyright 2023 Google LLC
#
# All the packages in telemetry/ required to be installed into the target
# or made available to the host are placed here.
#
# There are three variables to distinguish samples, packages and host packages.

SDV_PLATFORM_PACKAGES = \
    deployment_configuration.json \
    libsdvrpc

SDV_PLATFORM_SAMPLE_PACKAGES =

# SDV proxy application for forwarding the connection between different VMs
SDV_PLATFORM_HOST_PACKAGES = \
    host_deployment_configuration.json \
    sdv_proxy

PRODUCT_PACKAGES += $(SDV_PLATFORM_PACKAGES) $(SDV_PLATFORM_SAMPLE_PACKAGES)

ifneq ($(SDV_PREBUILT),true)
    PRODUCT_HOST_PACKAGES += $(SDV_PLATFORM_HOST_PACKAGES)
endif
