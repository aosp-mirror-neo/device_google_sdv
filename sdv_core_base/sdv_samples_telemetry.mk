# Copyright 2023-2024 Google LLC
#
# All the samples in telemetry/.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

# TODO: b/343460855 - Remove configurable publisher from SDV after RPC support
# TODO: b/420890689 - Remove `sdv_telemetry_dt_publisher_for_fetch_last_message_e2e_test`
#       after the Simulator supports simulation of Data Tunnel publishers.
SDV_CORE_TELEMETRY_SAMPLES_PACKAGES += \
    telemetry_rust_c_client \
    telemetry_sample_data_tunnel_publisher_speed \
    telemetry_sample_data_tunnel_publisher_tire_pressure \
    telemetry_sample_data_tunnel_publisher_error_report \
    telemetry_sample_middleware_publisher \
    telemetry_sample_rpc_publisher \
    dt_telemetry_sample_publisher \
    telemetry_sample_publisher \
    telemetry_sample_getter_publisher \
    sdv_telemetry_simulator \
    sdv_telemetry_cross_partition_client \
    sdv_telemetry_dt_publisher_for_fetch_last_message_e2e_test \
    telemetry_test_config.textproto \


SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_CORE_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_CORE_TELEMETRY_SAMPLES_PACKAGES, $(SDV_CORE_TELEMETRY_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES, $(SDV_CORE_TELEMETRY_HOST_SAMPLES_PACKAGES))
