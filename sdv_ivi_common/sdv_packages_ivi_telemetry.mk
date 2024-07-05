# Copyright 2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the IVI target
# or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.
#
# There are four variables to distinguish device samples/packages and
# host samples/packages.

SDV_IVI_TELEMETRY_PACKAGES = \
    sdv_ivi_telemetry_service_agent

SDV_IVI_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_rust_c_client \
    telemetry_sample_publisher \
    sdv_telemetry_simulator

SDV_IVI_TELEMETRY_HOST_PACKAGES =

SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_IVI_TELEMETRY_PACKAGES) $(SDV_IVI_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_TELEMETRY_HOST_PACKAGES) $(SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES)
