# Copyright 2023-2024 Google LLC
#
# All the packages from automotive_services/ required to be installed into the target
# or made available to the host are placed here.

SDV_AUTOMOTIVE_SERVICES_PACKAGES = \
    sdv_vpm_agent \
    com.sdv.google.diagnostics \
    com.sdv.google.vpm \
    com.sdv.google.concal \

SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES)
