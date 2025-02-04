# Copyright 2025 Google LLC
#
# Modules to be included in the performance benchmarking images.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_PERF_PACKAGES = \
    performance_custom_mode_dispatcher \
    com.sdv.google.performance.apex0 \
    com.sdv.google.performance.apex1 \
    com.sdv.google.performance.apex2 \
    com.sdv.google.performance.apex3 \
    com.sdv.google.performance.apex4 \
    com.sdv.google.performance.apex5 \
    com.sdv.google.performance.apex6 \
    com.sdv.google.performance.apex7 \
    com.sdv.google.performance.apex8 \
    com.sdv.google.performance.apex9 \
    com.sdv.google.performance.apex10 \
    com.sdv.google.performance.apex11 \
    com.sdv.google.performance.apex12 \
    com.sdv.google.performance.apex13 \
    com.sdv.google.performance.apex14 \
    com.sdv.google.performance.apex15 \
    com.sdv.google.performance.apex16 \
    com.sdv.google.performance.apex17 \
    com.sdv.google.performance.apex18 \
    com.sdv.google.performance.apex19 \
    com.sdv.google.performance.apex20 \
    com.sdv.google.performance.apex21 \
    com.sdv.google.performance.apex22 \
    com.sdv.google.performance.apex23 \
    com.sdv.google.performance.apex24 \
    com.sdv.google.performance.apex25 \
    com.sdv.google.performance.apex26 \
    com.sdv.google.performance.apex27 \
    com.sdv.google.performance.apex28 \
    com.sdv.google.performance.apex29 \
    com.sdv.google.performance.apex30 \
    com.sdv.google.performance.apex31 \
    com.sdv.google.performance.apex32 \
    com.sdv.google.performance.apex33 \
    com.sdv.google.performance.apex34 \
    com.sdv.google.performance.apex35 \
    com.sdv.google.performance.apex36 \
    com.sdv.google.performance.apex37 \
    com.sdv.google.performance.apex38 \
    com.sdv.google.performance.apex39 \
    com.sdv.google.performance.apex40 \
    com.sdv.google.performance.apex41 \
    com.sdv.google.performance.apex42 \
    com.sdv.google.performance.apex43 \
    com.sdv.google.performance.apex44 \
    com.sdv.google.performance.apex45 \
    com.sdv.google.performance.apex46 \
    com.sdv.google.performance.apex47 \
    com.sdv.google.performance.apex48 \
    com.sdv.google.performance.apex49 \

PRODUCT_PACKAGES += $(SDV_PERF_PACKAGES)

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.sdv.orchestrator_config_path=system_ext/etc/orch/performance/orch_vm_config.textproto
