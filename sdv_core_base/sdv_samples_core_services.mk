# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# All the samples from core_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_CORE_SERVICES_SAMPLES_PACKAGES += \
    com.sdv.google.sample.apex.consumer \
    com.sdv.google.sample.apex.provider \
    sdv_apex_update_sample_catalog_files-vsidl-config.binpb \
    com.sdv.google.sample.hello.apex \
    com.sdv.google.sample.test1 \
    com.sdv.google.sample.logging \
    com.android.sdv.sample.service_bundles_registry.apex_with_one_service_bundle_cpp \
    com.android.sdv.sample.service_bundles_registry.apex_with_one_service_bundle_rust \
    com.android.sdv.sample.service_bundles_registry.apex_with_two_service_bundles_cpp_rust \
    com.android.sdv.sample.service_bundles_registry.apex_configurable \
    com.android.sdv.sample.service_bundles_registry.apex_with_invalid_sdv_metadata \
    com.sdv.google.sample.multivd.ipv4 \
    com.sdv.google.sample.multivd.vsock \
    com.sdv.google.sample.lifecycle.apex \
    com.sdv.google.sample.lifecycle.userid.apex \
    com.sdv.google.sample.orch.apex \
    com.sdv.google.sample.updatable_flags.apex.test \
    com.android.sdv.sample.complex \
    com.android.sdv.sample.bar \
    com.android.sdv.sample.baz \
    com.android.sdv.sample.foo \
    com.android.sdv.sample.qux \
    com.sdv.google.sample.vsidl_provider.apex_with_per_bundle_config_file \
    com.sdv.google.sample.vsidl_provider.apex_with_shared_config_file \
    com.sdv.google.sample.vsidl_vhal_proxy_integration \
    com.sdv.google.sample.someip \
    com.sdv.google.sample.testing.sdv_dump \
    someip_samples_orch_config \
    hm_suspend_to_ram_test_vm_orch_config \
    cujs_orchestration_configurations \
    com.sdv.google.sample.update_manager.client \
    com.sdv.google.test.authz.bar \
    com.sdv.google.test.authz.foo \
    com.sdv.google.test.authz.local_vm_acl_policy_provider \
    com.sdv.tm \
    com.android.sdv.sample.perf5 \
    com.android.sdv.sample.perf6 \
    com.android.sdv.sample.stresstest \
    com.android.sdv.test_messages \
    android.sdv.samples.gateway \
    liblifecycle_cpp_service_bundle_test \
    sdv_flag_example \
    sdv_oem_partition_update_client \
    sdv_vsomeip_temperature_tester \
    sdv_vsomeip_conf_counter_tester_target \
    sdv_vsomeip_counter_tester \
    sdv_vsomeip_cuj_core_023 \
    sdv_vsomeip_cuj_core_026 \
    sdv_vsomeip_sdv_hello_tester \
    sdv_vsomeip_hey_tester \
    sdv_vsomeip_group_tester \
    sdv_vsomeip_side_mirror_tester \
    sdv_vsomeip_pubsub_benchmark \
    sdv_vsomeip_road_sensor_tester \
    sdv_vsomeip_object_sensor_tester \
    sdv_vsomeip_tire_pressure_sample \
    sdv_vsomeip_robustness_tester \
    orch_custom_mode_sample \
    persistent_binder_test_service \
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
    com.android.sdv.samples \
    com.android.sdv.samples.rpc \
    sdv_dt_mw_publisher_rs \
    sdv_dt_mw_subscriber_rs \
    libhealth_vsidl_with_bp_file-vsidl-config.binpb \
    sample_product_ota_postinstall_data \
    sample_system_ota_postinstall_data \
    update_engine_product_partition_post_install \
    update_engine_system_partition_post_install

# TODO: b/361610453 - include in com.sdv.google.sample.logging
SDV_CORE_SERVICES_SAMPLES_PACKAGES += structured_logging_sdv_rust_sample

SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES += \
    sdv_vsomeip_hello_service_sample \
    sdv_vsomeip_sdv_hello_client_sample \
    sdv_vsomeip_tire_pressure_sample \
    sdv_vsomeip_vehicle_health_monitor_sample \
    sdv_vsomeip_cuj_core_026 \
    sdv_vsomeip_cuj_core_023 \
    sdv_vsomeip_pubsub_benchmark \
    sdv_vsomeip_vehicle_data_sample

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_CORE_SERVICES_SAMPLES_PACKAGES, $(SDV_CORE_SERVICES_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES, $(SDV_CORE_SERVICES_HOST_SAMPLES_PACKAGES))

# A/B updates post install configuration.
# Post install scripts can be added for other partitions in the same way.
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_product=true \
    POSTINSTALL_PATH_product=bin/update_engine_product_partition_post_install \
    FILESYSTEM_TYPE_product=erofs \
    POSTINSTALL_OPTIONAL_product=false

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/update_engine_system_partition_post_install \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=false
