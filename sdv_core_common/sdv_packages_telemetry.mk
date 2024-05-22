# Copyright 2023-2024 Google LLC
#
# All the packages in telemetry/ required to be installed into the core/media
# targets or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.
#
# There are four variables to distinguish device samples/packages and
# host samples/packages.

SDV_CORE_TELEMETRY_PACKAGES = \
    sdv_telemetry_service_agent

SDV_CORE_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_rust_c_client \
    telemetry_sample_data_tunnel_publisher_speed \
    dt_telemetry_sample_publisher

SDV_CORE_TELEMETRY_HOST_PACKAGES =

SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_CORE_TELEMETRY_PACKAGES) $(SDV_CORE_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_TELEMETRY_HOST_PACKAGES) $(SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES)
