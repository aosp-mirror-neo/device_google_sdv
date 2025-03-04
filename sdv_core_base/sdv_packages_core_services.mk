# Copyright 2023-2024 Google LLC
#
# All the packages from core_services/ required to be installed into the target
# or made available to the host are placed here.

ifeq ($(SDV_SOMEIP_BROKER_CONFIG),)
  $(error $$SDV_SOMEIP_BROKER_CONFIG not set)
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
    sdv.sample.apex.fake.update.manager \
    sdv_health_monitor \
    $(SDV_SOMEIP_BROKER_CONFIG) \
    com.sdv.google.health \
    com.sdv.google.orchestrator \
    com.sdv.google.update_manager \
    com.sdv.google.vsidl_provider \
    google.sdv.dt \
    sdv_vsidl_provider_agent \

SDV_CORE_SERVICES_HOST_PACKAGES += \
    vsidl_rc_generator \
    vsidlc

PRODUCT_PACKAGES += $(SDV_CORE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_SERVICES_HOST_PACKAGES)
