# Copyright 2023-2024 Google LLC
#
# All the samples from core_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_CORE_SERVICES_SAMPLES_PACKAGES = \
    com.sdv.google.sample.apex.consumer \
    com.sdv.google.sample.apex.provider \
    com.sdv.google.sample.hello.apex \
    com.sdv.google.sample.test1 \
    com.sdv.google.sample.logging \
    com.sdv.google.sample.service_bundles_registry.apex_with_one_service_bundle_cpp \
    com.sdv.google.sample.service_bundles_registry.apex_with_one_service_bundle_rust \
    com.sdv.google.sample.service_bundles_registry.apex_with_two_service_bundles_cpp_rust \
    com.sdv.google.sample.service_bundles_registry.apex_configurable \
    com.sdv.google.sample.service_bundles_registry.apex_with_invalid_sdv_metadata \
    com.sdv.google.sample.multivd.ipv4 \
    com.sdv.google.sample.multivd.vsock \
    com.sdv.google.sample.lifecycle.apex \
    com.sdv.google.sample.orch.apex \
    com.sdv.google.sample.updatable_flags.apex.test \
    com.sdv.google.sample.bar \
    com.sdv.google.sample.baz \
    com.sdv.google.sample.foo \
    com.sdv.google.sample.qux \
    com.sdv.google.sample.vsidl_provider \
    com.sdv.google.sample.vsidl_vhal_proxy_integration \
    com.sdv.google.sample.someip \
    someip_samples_orch_config \
    cujs_orchestration_configurations \
    com.sdv.google.sample.update_manager.client \
    com.sdv.google.test.authz.local_vm_acl_policy_provider \
    com.sdv.tm \
    com.sdv.google.sample.perf5 \
    com.sdv.google.sample.perf6 \
    android.sdv.samples.gateway \
    liblifecycle_cpp_service_bundle_test \
    middleware_someip_sample \
    sdv_oem_partition_update_client \
    sdv_vsomeip_temperature_tester \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_sdv_hello_tester \
    sdv_vsomeip_hey_tester \
    sdv_vsomeip_group_tester \
    sdv_vsomeip_side_mirror_tester \
    sdv_vsomeip_pubsub_benchmark \
    someip_rpc_someip_server \
    someip_rpc_sdv_server \
    orch_custom_mode_sample \
    com.sdv.google.sample.orchestration \
    sdv_service_bundle \
    sdv_tire_pressure \
    sdv_range_remaining_subscriber \
    someip_catalog_protos_with_bp_file-vsidl-config.binpb \
    com.sdv.google.sample.tracing \
    sdv_server_rust_tracing_sample \
    rochambeau_player_rs \
    rochambeau_judge_rs \
    com.sdv.google.sample.sqlite \
    com.sdv.sample_oem.health.monitored \
    com.sdv.sample_oem.health.monitoring \
    sdv_dice_root_key_extraction_tool \
    com.sdv.someip \
    sdv_integration_test_health_monitored_service \
    sdv_vsomeip_vehicle_health_monitor_sample_target \
    telemetry_catalog_protos_with_bp_file-vsidl-config.binpb \
    com.google.sdv.samples \
    com.google.sdv.rpcsamples \

# TODO: b/361610453 - include in com.sdv.google.sample.logging
SDV_CORE_SERVICES_SAMPLES_PACKAGES += structured_logging_sdv_rust_sample

SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES += \
    sdv_vsomeip_hello_service_sample \
    sdv_vsomeip_sdv_hello_client_sample \
    sdv_vsomeip_tire_pressure_sample \
    sdv_vsomeip_vehicle_health_monitor_sample \
    sdv_vsomeip_cuj_core_026 \
    sdv_vsomeip_cuj_core_023 \
    sdv_vsomeip_pubsub_benchmark

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES)
