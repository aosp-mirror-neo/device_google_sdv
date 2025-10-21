# Copyright 2023-2024 Google LLC
#
# All the packages from telemetry/ required to be installed into the core/media
# targets or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.

SDV_CORE_TELEMETRY_PACKAGES += \
    sdv_telemetry_service_agent

SDV_CORE_TELEMETRY_HOST_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_CORE_TELEMETRY_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_CORE_TELEMETRY_HOST_PACKAGES)

$(call soong_config_set, sdv_config, SDV_CORE_TELEMETRY_PACKAGES, $(SDV_CORE_TELEMETRY_PACKAGES))
$(call soong_config_set, sdv_config, SDV_CORE_TELEMETRY_HOST_PACKAGES, $(SDV_CORE_TELEMETRY_HOST_PACKAGES))
