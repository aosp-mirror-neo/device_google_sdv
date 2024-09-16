# Copyright 2023-2024 Google LLC
#
# All the packages from automotive_services/ required to be installed into the target
# or made available to the host are placed here.

# Vehicle and Power mode agent and poc.
SDV_AUTOMOTIVE_SERVICES_PACKAGES = \
    sdv_vpm_agent \


SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES)
