# Copyright 2023-2024 Google LLC
#
# All the packages from core_services/ required to be installed into the target
# or made available to the host are placed here.

ifeq ($(SDV_SOMEIP_BROKER_CONFIG),)
  $(error $$SDV_SOMEIP_BROKER_CONFIG not set)
endif

ifeq ($(SDV_SOMEIP_AGENT_MODULES),)
  $(warning $$SDV_SOMEIP_AGENT_MODULES is not set, so no SomeIP Agent will be installed. \
    For a properly working system, make sure that an implementation will be installed!)
endif

SDV_CORE_SERVICES_PACKAGES += \
    libsdv_lifecycle_client_rust \
    libsdv_lifecycle_client_cpp \
    libsdv_config_provider \
    orch_config.textproto \
    sdv_lifecycle_agent \
    sdv_orchestration_agent \
    sdv_service_bundles_registry_agent \
    lifecycle_service_bundle_runner \
    sdv_someip_broker_agent_comms \
    sdv_update_manager_agent \
    sdv_health_monitor \
    $(SDV_SOMEIP_AGENT_MODULES) \
    $(SDV_SOMEIP_BROKER_CONFIG) \
    com.sdv.google.health \
    com.sdv.google.orchestrator \
    com.sdv.google.update_manager \
    com.sdv.google.vsidl_provider \
    google.sdv.dt \
    sdv_vsidl_provider_agent

# The Communication Stack Agents and init_open_dice
SDV_CORE_SERVICES_PACKAGES += \
    dt_agent \
    rpcagent \
    init_open_dice \
    sdv_sd_agent

# The testing utilities.
SDV_CORE_SERVICES_PACKAGES += \
    sdv_noop_wm

SDV_CORE_SERVICES_HOST_PACKAGES += \
    someip_translation_generator \
    vsidl_rc_generator \
    vsidlc

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_PACKAGES)

$(call soong_config_set, sdv_config, SDV_CORE_SERVICES_PACKAGES, $(SDV_CORE_SERVICES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_CORE_SERVICES_HOST_PACKAGES, $(SDV_CORE_SERVICES_HOST_PACKAGES))
