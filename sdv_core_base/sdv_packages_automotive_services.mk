# Copyright 2023-2024 Google LLC
#
# All the packages in automotive_services/ required to be installed into the target
# or made available to the host are placed here.
#
# There are four variables to distinguish device samples/packages and host samples/packages.

# Vehicle and Power mode agent and poc.
SDV_AUTOMOTIVE_SERVICES_PACKAGES = \
    sdv_vpm_agent

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES = \
    diag_manager_sample \
    diag_provider1_sample \
    diag_provider2_sample \
    sdv_con_cal_client \
    sdv_con_cal_service \
    libdiagnostics_sample_catalog-diagnostics-config.binpb \
    libdiagnostics_sample_catalog-vsidl-config.binpb \
    vepsm \
    vpm_power_state_client \
    vpm_vehicle_state_client \
    sdv_user_preferences_service \
    sdv_hvac_service \
    sdv_car_seats_service \
    sdv_hmi_service \


SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES =

SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES) $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES) $(SDV_AUTOMOTIVE_SERVICES_HOST_SAMPLES_PACKAGES)
