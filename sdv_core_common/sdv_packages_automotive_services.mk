# Copyright 2023 Google LLC
#
# All the packages in automotive_services/ required to be installed into the target
# or made available to the host are placed here.
#
# There are three variables to distinguish samples, packages and host packages.

# Vehicle and Power mode agent and poc.
SDV_AUTOMOTIVE_SERVICES_PACKAGES = \
    sdv_vpm_agent_poc \
    sdv_vpm_agent

SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES = \
    diag_manager_sample \
    diag_data_item1_service_sample \
    diag_data_item2_service_sample \
    sdv_con_cal_client \
    sdv_con_cal_service \
    vpm_client_sample \
    vpm_system_agent_sample \
    libdiagnostics_sample_catalog-diagnostics-config.binpb \
    libdiagnostics_sample_catalog-vsidl-config.binpb

SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES) $(SDV_AUTOMOTIVE_SERVICES_SAMPLES_PACKAGES)

ifneq ($(SDV_PREBUILT),true)
    PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES)
endif
