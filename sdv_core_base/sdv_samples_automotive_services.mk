# Copyright 2023-2024 Google LLC
#
# All the samples from automotive_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES += \
    com.sdv.google.sample.diagnostics_update \
    com.sdv.oem.sample.concal \
    com.sdv.oem.sample.diagnostics \
    libdiagnostics_update_sample_catalog_files-vsidl-config.binpb \
    libdiagnostics_update_sample_catalog_files-vsidl-config.binpb-V2 \
    libdiagnostics_v1_sample_catalog_files-vsidl-config.binpb \
    vpm_power_state_client \
    vpm_vehicle_state_client \
    test_vm_health_subscriber \
    com.sdv.oem.user_preferences \
    user_preferences_samples_orch_config \
    diagnostics_provider1_sample_orch_config \
    concal_sample_orch_config \

SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES))
