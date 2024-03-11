# Copyright 2023-2024 Google LLC
#
# All the packages in core_services/ required to be installed into the target
# or made available to the host are placed here.
#
# There are four variables to distinguish device samples/packages and host samples/packages.

SDV_CORE_SERVICES_PACKAGES = \
    dt_agent \
    libsdv_authn \
    libsdv_authz \
    libsdv_dt_core \
    libsdv_dt \
    libsdv_dt_rust \
    libsdv_lifecycle_client \
    libsdv_sd \
    libsdv_sd_rs \
    libsdv_middleware_pubsub \
    libsdv_config_provider \
    orch_config.textproto \
    rpcagent \
    sdv_lifecycle_agent \
    sdv_mesh_agent \
    sdv_orchestration_agent \
    sdv_package_registry_agent \
    sdv_sd_agent \
    sdv_sd_cli \
    sdv_someip_broker_agent \
    broker_config.json \
    sdv_someip_discovery_agent \
    sdv_someip_stack_agent \
    someip_stack_deployment.json \
    vsomeip_config.json \
    vsock_local_cid \
    vvm_config.textproto \
    libsomeip_messages_catalog-someip-config.binpb \
    libsomeip_messages_catalog-vsidl-config.binpb

# Sample modules in core_services/
SDV_CORE_SERVICES_SAMPLES_PACKAGES = \
    client_rust_tokio_sdv_sample \
    client_sdv_benchmark_sample \
    com.android.sdv.hello.apex \
    com.android.sdv.samples.rochambeau \
    com.android.sdv.samples.rpc \
    com.android.sdv.samples.multivd.ipv4 \
    com.android.sdv.samples.multivd.vsock \
    compile_time_log_filtering_sdv_sample \
    dt_sample_client_cpp \
    dt_sample_publisher_rust \
    dt_sample_subscriber_rust \
    lifecycle_sample \
    lifecycle_sample_rust \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    logging_sdv_sample \
    middleware_someip_sample \
    sdv_client_cpp_tracing_sample \
    sdv_client_rust_tracing_sample \
    sdv_cluster_grpc_client_cpp \
    sdv_cluster_grpc_server_cpp \
    sdv_compatibility_sample_publisher_old_service \
    sdv_compatibility_sample_publisher_new_service \
    sdv_compatibility_sample_subscriber_new_service \
    sdv_compatibility_sample_subscriber_old_service \
    sdv_grpc_client \
    sdv_grpc_server \
    sdv_mirror_controller_service \
    sdv_mirror_manager_service \
    sdv_mirror_modern_service \
    sdv_mirror_status_printer_service \
    sdv_sample_property_service \
    sdv_sample_rpc_client \
    sdv_sample_rpc_server \
    sdv_sample_multivd_ipv4_server \
    sdv_sample_multivd_ipv4_client \
    sdv_sample_multivd_vsock_client \
    sdv_sample_multivd_vsock_server \
    sdv_server_cpp_tracing_sample \
    sdv_server_rust_tracing_sample \
    sdv_tire_alert_service \
    sdv_tire_monitor_service \
    sdv_tire_sensor_reader_service \
    sdv_tire_status_supplier_service \
    sdv_tire_status_consumer_service \
    sdv_tpms_grpc_client_cpp \
    sdv_tpms_grpc_server_cpp \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_conf_hello_tester_target \
    sdv_vsomeip_conf_virtual_ecu_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_virtual_ecu \
    server_rust_tokio_sdv_sample \
    service_authn_sample_bench \
    service_authn_sample_rs \
    some_ip_dt_sample \
    structured_logging_sdv_sample \
    rpc_middleware_someip \
    orchestration_service_test \
    lifecycle_service_test \
    lifecycle_rust_service_test \

SDV_CORE_SERVICES_HOST_PACKAGES += \
    vsidl_code_generator \

SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES += \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_virtual_ecu

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_PACKAGES) $(SDV_CORE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_PACKAGES) $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES)
