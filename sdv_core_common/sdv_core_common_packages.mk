# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

# SDV proxy application for forwarding the connection between different VMs
PRODUCT_HOST_PACKAGES += sdv_proxy \
    host_deployment_configuration.json \
    sdv_vsomeip_virtual_ecu \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_counter_tester \

## SDV Core components (agent, libraries)
# RPC library
PRODUCT_PACKAGES += libsdvrpc
# Package registry agent
PRODUCT_PACKAGES += sdv_package_registry_agent
# Lifecycle manager agent
PRODUCT_PACKAGES += sdv_lifecycle_agent
# Service discovery library
PRODUCT_PACKAGES += libsdv_sd
# Service discovery agent
PRODUCT_PACKAGES += sdv_sd_agent
# Service discovery CLI utility
PRODUCT_PACKAGES += sdv_sd_cli
# Service Authentication library
PRODUCT_PACKAGES += libsdv_authn
# SOME/IP broker
PRODUCT_PACKAGES += sdv_someip_broker_agent
# SOME/IP service discovery proxy
PRODUCT_PACKAGES += sdv_someip_discovery_agent
# SOME/IP stack agent
PRODUCT_PACKAGES += sdv_someip_stack_agent
# Vehicle and Power mode agent
PRODUCT_PACKAGES += sdv_vpm_agent
# Rpc agent
PRODUCT_PACKAGES += rpcagent
# Orchestrator agent
PRODUCT_PACKAGES += sdv_orchestration_agent
# Mesh agent
PRODUCT_PACKAGES += sdv_mesh_agent


# SDV deployment configuration
PRODUCT_PACKAGES += deployment_configuration.json \
    someip_deployment.json \
    someip_stack_deployment.json \
    vvm_config.textproto \
    orch_config.textproto \
    vsomeip_config.json \

# SDV Sample applications
PRODUCT_PACKAGES += \
    server_sdv_sample \
    client_sdv_sample \
    server_rpc_sdv_sample \
    client_rpc_sdv_sample \
    server_rust_sdv_sample \
    client_rust_sdv_sample \
    server_rust_tokio_sdv_sample \
    client_rust_tokio_sdv_sample \
    com.android.sdv.samples.rpc \
    lifecycle_sample \
    logging_sdv_sample \
    structured_logging_sdv_sample \
    compile_time_log_filtering_sdv_sample \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    tracing_sdv_rust_sample \
    com.android.sdv.samples.rochambeau \
    service_authn_sample_rs \
    service_authn_sample_bench \
    client_sdv_benchmark_sample \
    sdv_poc \
    sdv_poc_client \
    com.android.sdv.hello.apex \
    dt_agent \
    libsdv_dt \
    dt_sample_client_cpp \
    client_some_ip_sdv_sample \
    sdv_server_cpp_tracing_sample \
    sdv_client_cpp_tracing_sample \
    sdv_server_rust_tracing_sample \
    sdv_client_rust_tracing_sample \
    vpm_client_sample\
    vpm_system_agent_sample \
    sdv_vsomeip_virtual_ecu \
    sdv_vsomeip_hello_tester \
    sdv_vsomeip_counter_tester \
    libsdv_dt_rust \
    dt_sample_publisher_rust \
    dt_sample_subscriber_rust \
    diag_manager_sample \
    diag_service_sample \
    sdv_sample_property_service \
    sdv_vhal_proxy_subscriber \
    some_ip_dt_sample \

# SDV telemetry service executables
PRODUCT_PACKAGES += \
    sdv_telemetry_service \
    telemetry_cpp_client \
    telemetry_rust_client \
    telemetry_rust_c_client
