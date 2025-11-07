# Copyright 2023-2024 Google LLC
#
# All the packages from automotive_services/ required to be installed into the target
# or made available to the host are placed here.

# Check whether all optional default services are set to a variant
ifeq ($(SDV_VEHICLE_POWER_STATE_MANAGER_MODULE),)
  $(error $$SDV_VEHICLE_POWER_STATE_MANAGER_MODULE is not set, so no Vehicle Power State Manager will be installed. \
    For a properly working system, make sure that an implementation will be installed!)
endif

ifeq ($(SDV_DIAGNOSTICS_AGENT_MODULE),)
  $(warning $$SDV_DIAGNOSTICS_AGENT_MODULE is not set, so no Diagnostic Agent will be installed. \
    For a properly working system, make sure that an implementation will be installed!)
endif

SDV_AUTOMOTIVE_SERVICES_PACKAGES += \
    sdv_vpm_agent \
    com.sdv.google.diagnostics \
    com.sdv.google.vpm \
    com.sdv.google.vpm.client \
    com.sdv.google.concal \
    com.sdv.google.user_preferences \
    $(SDV_DIAGNOSTICS_AGENT_MODULE) \
    $(SDV_VEHICLE_POWER_STATE_MANAGER_MODULE)

SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES)

$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES, $(SDV_AUTOMOTIVE_SERVICES_HOST_PACKAGES))
