# Copyright 2023-2024 Google LLC
#
# All the samples from core_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_CORE_SERVICES_SAMPLES_PACKAGES = \
    client_rust_tokio_sdv_sample \
    client_sdv_benchmark_sample \
    com.android.sdv.hello.apex \
    com.android.sdv.samples.service_bundle_registry.apex_with_one_service_bundle_cpp \
    com.android.sdv.samples.service_bundle_registry.apex_with_one_service_bundle_rust \
    com.android.sdv.samples.service_bundle_registry.apex_with_two_service_bundles_cpp_rust \
    com.android.sdv.samples.rochambeau \
    com.android.sdv.samples.rpc \
    com.android.sdv.samples.multivd.ipv4 \
    com.android.sdv.samples.multivd.vsock \
    compile_time_log_filtering_sdv_sample \
    com.android.sdv.samples.lifecycle.apex \
    com.android.sdv.samples.orch.apex \
    liblifecycle_rust_service_bundle_test \
    liblifecycle_cpp_service_bundle_test \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    logging_sdv_sample \
    middleware_someip_sample \
    sdv_compatibility_sample_publisher_old_service \
    sdv_compatibility_sample_publisher_new_service \
    sdv_compatibility_sample_subscriber_new_service \
    sdv_compatibility_sample_subscriber_old_service \
    sdv_cuj_core_001_pub \
    sdv_cuj_core_001_sub \
    sdv_same_unit_type_sample_publisher_service \
    sdv_same_unit_type_sample_subscriber_service \
    sdv_same_unit_type_sample_server_service \
    sdv_same_unit_type_sample_client_service \
    sdv_same_unit_type_sample_subscriber_service_cc \
    sdv_same_unit_type_sample_server_service_cc \
    sdv_same_unit_type_sample_publisher_service_cc \
    sdv_same_unit_type_sample_client_service_cc \
    sdv_mw_metadata_sample_publisher_service \
    sdv_mw_metadata_sample_subscriber_service \
    sdv_mirror_controller_service \
    sdv_mirror_manager_service \
    sdv_mirror_sdv_mirror_modern_service \
    sdv_mirror_status_printer_service \
    sdv_sample_property_service \
    sdv_tire_alert_service \
    sdv_tire_monitor_service \
    sdv_tire_sensor_reader_service \
    sdv_tire_status_supplier_service \
    sdv_tire_status_consumer_service \
    sdv_update_manager_client \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_sdv_hello_tester \
    sdv_vsomeip_hey_tester \
    sdv_vsomeip_group_tester \
    sdv_vsomeip_side_mirror_tester \
    server_rust_tokio_sdv_sample \
    structured_logging_sdv_rust_sample \
    structured_logging_sdv_sample \
    someip_rpc_someip_server \
    someip_rpc_sdv_server \
    orch_custom_mode_sample_charging \
    orch_custom_mode_sample_tire_pressure \
    sdv_health_monitor \
    sdv_sample_health_monitored_service \
    sdv_sample_second_health_monitored_service \
    sdv_sample_health_monitoring_service \
    sdv_service_bundle \
    libsomeip_messages_catalog-someip-config.binpb \
    libsomeip_messages_catalog-vsidl-config.binpb \
    libhealthmonitor_messages_catalog-vsidl-config.binpb \
    libhealthmonitor_messages_catalog-config.binpb \
    com.android.sdv.samples.tracing \
    sdv_server_rust_tracing_sample \

SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES += \
    sdv_vsomeip_hello_service_sample \
    sdv_vsomeip_sdv_hello_client_sample \
    sdv_vsomeip_tire_pressure_sample \
    sdv_vsomeip_vehicle_health_monitor_sample

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES)
