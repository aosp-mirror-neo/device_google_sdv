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
    test_vm_health_subscriber \

PRODUCT_PACKAGES += $(SDV_PERF_PACKAGES)

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.sdv.orchestrator_config_path=system_ext/etc/orch/performance/orch_vm_config.textproto
