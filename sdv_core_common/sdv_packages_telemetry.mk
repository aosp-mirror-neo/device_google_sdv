# Copyright 2023-2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the target
# or made available to the host are placed here.
#
# There are four variables to distinguish device samples/packages and host samples/packages.

SDV_TELEMETRY_PACKAGES = \
    sdv_telemetry_service_agent

SDV_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_cpp_client \
    telemetry_rust_c_client \
    telemetry_sample_publisher \
    dt_telemetry_sample_publisher

SDV_TELEMETRY_HOST_PACKAGES =

SDV_TELEMETRY_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_TELEMETRY_PACKAGES) $(SDV_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_TELEMETRY_HOST_PACKAGES) $(SDV_TELEMETRY_HOST_SAMPLES_PACKAGES)
