# Copyright 2023-2024 Google LLC
#
# All the packages in core_services/ required to be installed into the target
# or made available to the host are placed here.
#
# There are four variables to distinguish device samples/packages and host samples/packages.

SDV_CORE_SERVICES_PACKAGES = \
    libsdv_lifecycle_client_rust \
    libsdv_lifecycle_client_cpp \
    libsdv_middleware_pubsub \
    libsdv_config_provider \
    orch_config.textproto \
    sdv_lifecycle_agent \
    sdv_orchestration_agent \
    sdv_service_bundles_registry_agent \
    lifecycle_service_bundle_runner \
    sdv_someip_broker_agent \
    broker_config.json \
    sdv_someip_stack_agent \
    someip_stack_deployment.json \
    vsomeip_config.json \
    libsomeip_messages_catalog-someip-config.binpb \
    libsomeip_messages_catalog-vsidl-config.binpb \

# Sample modules in core_services/
SDV_CORE_SERVICES_SAMPLES_PACKAGES = \
    client_rust_tokio_sdv_sample \
    client_sdv_benchmark_sample \
    com.android.sdv.hello.apex \
    com.android.sdv.samples.service_bundle_registry.apex_with_one_service_bundle_a \
    com.android.sdv.samples.rochambeau \
    com.android.sdv.samples.rpc \
    com.android.sdv.samples.multivd.ipv4 \
    com.android.sdv.samples.multivd.vsock \
    compile_time_log_filtering_sdv_sample \
    com.android.sdv.samples.lifecycle.apex \
    liblifecycle_rust_service_bundle_test \
    liblifecycle_cpp_service_bundle_test \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    logging_sdv_sample \
    middleware_someip_sample \
    sdv_client_cpp_tracing_sample \
    sdv_client_rust_tracing_sample \
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
    sdv_mirror_controller_service \
    sdv_mirror_manager_service \
    sdv_mirror_sdv_mirror_modern_service \
    sdv_mirror_status_printer_service \
    sdv_sample_property_service \
    sdv_server_cpp_tracing_sample \
    sdv_server_rust_tracing_sample \
    sdv_tire_alert_service \
    sdv_tire_monitor_service \
    sdv_tire_sensor_reader_service \
    sdv_tire_status_supplier_service \
    sdv_tire_status_consumer_service \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_sdv_hello_tester \
    sdv_vsomeip_hey_tester \
    sdv_vsomeip_side_mirror_tester \
    server_rust_tokio_sdv_sample \
    some_ip_dt_sample \
    structured_logging_sdv_rust_sample \
    structured_logging_sdv_sample \
    someip_rpc_someip_server \
    someip_rpc_sdv_server \
    orch_custom_mode_sample_charging \
    orch_custom_mode_sample_tire_pressure \
    sdv_health_monitor \
    sdv_sample_health_monitored_service \
    sdv_sample_second_health_monitored_service \
    sdv_sample_health_monitoring_service

SDV_CORE_SERVICES_HOST_PACKAGES += \
    vsidl_code_generator \

SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES += \
    sdv_vsomeip_hello_service_sample \
    sdv_vsomeip_sdv_hello_client_sample \
    sdv_vsomeip_tire_pressure_sample \
    sdv_vsomeip_vehicle_health_monitor_sample

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_PACKAGES) $(SDV_CORE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_PACKAGES) $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES)
