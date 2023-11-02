# Copyright 2023 Google LLC
#
# All the packages in core_services/ required to be installed into the target
# or made available to the host are placed here.

SDV_CORE_SERVICES_PACKAGES = \
    dt_agent \
    libsdv_authn \
    libsdv_dt_core \
    libsdv_dt \
    libsdv_dt_rust \
    libsdv_lifecycle_client \
    libsdv_sd \
    libsdv_sd_rs \
    libsdvmiddleware_pubsub \
    libsdv_config_provider \
    libsomeip_runtime \
    orch_config.textproto \
    rpcagent \
    sdv_lifecycle_agent \
    sdv_mesh_agent \
    sdv_orchestration_agent \
    sdv_package_registry_agent \
    sdv_sd_agent \
    sdv_sd_cli \
    sdv_someip_broker_agent \
    sdv_someip_discovery_agent \
    sdv_someip_stack_agent \
    someip_deployment.json \
    someip_stack_deployment.json \
    vsomeip_config.json \
    vsock_local_cid \
    vvm_config.textproto \
    someip-config.binpb \
    vsidl-config.binpb

# Sample modules in core_services/
SDV_CORE_SERVICES_SAMPLE_PACKAGES = \
    client_rpc_sdv_sample \
    client_rust_tokio_sdv_sample \
    client_sdv_benchmark_sample \
    client_sdv_sample \
    client_some_ip_sdv_sample \
    com.android.sdv.hello.apex \
    com.android.sdv.samples.rochambeau \
    com.android.sdv.samples.rpc \
    compile_time_log_filtering_sdv_sample \
    dt_sample_client_cpp \
    dt_sample_publisher_rust \
    dt_sample_subscriber_rust \
    lifecycle_sample \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    logging_sdv_sample \
    sdv_client_cpp_tracing_sample \
    sdv_client_rust_tracing_sample \
    sdv_poc \
    sdv_poc_client \
    sdv_sample_property_service \
    sdv_sample_rpc_client \
    sdv_sample_rpc_server \
    sdv_server_cpp_tracing_sample \
    sdv_server_rust_tracing_sample \
    sdv_tire_alert_service \
    sdv_tire_monitor_service \
    sdv_tire_sensor_reader_service \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_conf_hello_tester_target \
    sdv_vsomeip_conf_virtual_ecu_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_virtual_ecu \
    server_rpc_sdv_sample \
    server_rust_tokio_sdv_sample \
    server_sdv_sample \
    service_authn_sample_bench \
    service_authn_sample_rs \
    some_ip_dt_sample \
    structured_logging_sdv_sample \
    middleware_someip_sample \

# Sample services for tests
SDV_CORE_SERVICES_SAMPLE_PACKAGES += \
    orchestration_service_test \
    lifecycle_service_test \

SDV_CORE_SERVICES_HOST_PACKAGES += \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_virtual_ecu

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_PACKAGES) $(SDV_CORE_SERVICES_SAMPLE_PACKAGES)

ifneq ($(SDV_PREBUILT),true)
    PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_PACKAGES)
endif
