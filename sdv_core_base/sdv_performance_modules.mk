# Copyright 2025 Google LLC
#
# Modules to be included in the performance benchmarking images.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_PERF_PACKAGES = \
    com.sdv.google.performance.unit_type_owner \
    performance.hm.config \
    performance_custom_mode_dispatcher \
    com.sdv.google.performance.apex0 \
    com.sdv.google.performance.apex1 \
    com.sdv.google.performance.apex2 \
    com.sdv.google.performance.apex3 \
    com.sdv.google.performance.apex4 \
    com.sdv.google.performance.apex5 \
    com.sdv.someip \
    libhealth_vsidl_with_bp_file-vsidl-config.binpb \
    sdv_vsomeip_vehicle_health_monitor_sample_target \
    test_vm_health_subscriber \
    com.sdv.google.sample.bar \
    com.sdv.google.sample.baz \
    com.sdv.google.sample.foo \
    com.sdv.google.sample.qux \
    cujs_orchestration_configurations \
    hm_config_with_someip.textproto \
    hm_config_without_someip.textproto

PRODUCT_PACKAGES += $(SDV_PERF_PACKAGES)
