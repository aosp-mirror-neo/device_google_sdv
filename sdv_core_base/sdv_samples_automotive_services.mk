# Copyright 2023-2024 Google LLC
#
# All the samples from automotive_services/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES = \
    com.sdv.oem.sample.concal \
    diag_v1_provider1_sample \
    diag_v1_provider2_sample \
    sdv_con_cal_client \
    sdv_con_cal_service \
    vepsm \
    vpm_power_state_client \
    vpm_vehicle_state_client \
    sdv_user_preferences_service \
    sdv_hvac_service \
    sdv_car_seats_service \
    sdv_hmi_service \
    sdv_user_preferences_service_stable \
    sdv_hvac_service_stable \
    sdv_hmi_service_stable  \
    sdv_car_seats_service_stable \
    sdv_concal_sample_client \


SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES)
