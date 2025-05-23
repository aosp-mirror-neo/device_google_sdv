# Copyright 2023-2024 Google LLC
#
# All the samples from automotive_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES += \
    com.sdv.google.sample.diagnostics_update \
    com.sdv.oem.sample.concal \
    com.sdv.oem.sample.diagnostics \
    diag_v1_provider1_sample \
    diag_v1_provider2_sample \
    libdiagnostics_update_sample_catalog_files-vsidl-config.binpb \
    libdiagnostics_v1_sample_catalog_files-vsidl-config.binpb \
    vpm_power_state_client \
    vpm_vehicle_state_client \
    sdv_hvac_service_stable \
    sdv_hmi_service_stable  \
    sdv_car_seats_service_stable \
    sdv_concal_sample_client \
    com.sdv.oem.user_preferences \

SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES)
