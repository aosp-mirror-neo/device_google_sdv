# Copyright 2023-2024 Google LLC
#
# All the samples in telemetry/.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

# TODO: b/343460855 - Remove configurable publisher from SDV after RPC support
SDV_CORE_TELEMETRY_SAMPLES_PACKAGES = \
    telemetry_rust_c_client \
    telemetry_sample_data_tunnel_publisher_speed \
    telemetry_sample_data_tunnel_publisher_tire_pressure \
    telemetry_sample_data_tunnel_publisher_error_report \
    telemetry_sample_data_tunnel_publisher_middleware \
    telemetry_sample_rpc_publisher \
    dt_telemetry_sample_publisher \
    telemetry_sample_publisher \
    telemetry_sample_getter_publisher \
    sdv_telemetry_simulator \


SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_CORE_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES)
