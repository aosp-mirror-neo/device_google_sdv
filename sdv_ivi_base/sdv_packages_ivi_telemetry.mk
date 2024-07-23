# Copyright 2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the IVI target
# or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.

SDV_IVI_TELEMETRY_PACKAGES = \
    sdv_ivi_telemetry_service_agent

SDV_IVI_TELEMETRY_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_IVI_TELEMETRY_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_TELEMETRY_HOST_PACKAGES)
