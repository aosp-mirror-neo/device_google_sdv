# Copyright 2023-2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the target
# or made available to the host are placed here.
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.
#
# There are six variables to distinguish device samples/packages per target-
# SDV_Core or SDV_IVI, and host samples/packages.

SDV_CORE_TELEMETRY_PACKAGES = \
    sdv_telemetry_service_agent

SDV_CORE_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_rust_c_client \
    telemetry_sample_publisher \
    dt_telemetry_sample_publisher

SDV_IVI_TELEMETRY_PACKAGES = \
    sdv_ivi_telemetry_service_agent

SDV_IVI_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_ivi_rust_c_client \

SDV_TELEMETRY_HOST_PACKAGES =

SDV_TELEMETRY_HOST_SAMPLES_PACKAGES =

PRODUCT_HOST_PACKAGES += $(SDV_TELEMETRY_HOST_PACKAGES) $(SDV_TELEMETRY_HOST_SAMPLES_PACKAGES)
