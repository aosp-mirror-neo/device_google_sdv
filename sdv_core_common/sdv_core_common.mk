# Copyright 2023 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Software-Defined Vehicle Core

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.hardware.type=automotive \
    ro.logd.size=8M \

# Networking tools
PRODUCT_PACKAGES += \
    ping \
    ping6 \

# SDV proxy application for forwarding the connection between different VMs
PRODUCT_HOST_PACKAGES += sdv_proxy \
    host_deployment_configuration.json \

## SDV Core components (agent, libraries)
# Shared component (utiltites for Core agents and libraries)
PRODUCT_PACKAGES += libsdv_shared
# RPC library
PRODUCT_PACKAGES += libsdvrpc
# Package registry agent
PRODUCT_PACKAGES += sdv_package_registry_agent
# Lifecycle manager agent
PRODUCT_PACKAGES += sdv_lifecycle_agent
# Service discovery library
PRODUCT_PACKAGES += libsdv_sd
# Service discovery agent
PRODUCT_PACKAGES += sdv_sd_agent
# Service discovery CLI utility
PRODUCT_PACKAGES += sdv_sd_cli
# Service Authentication library
PRODUCT_PACKAGES += libsdv_authn

# SDV deployment configuration
PRODUCT_PACKAGES += deployment_configuration.json \
    someip_deployment.json \

# SDV Sample applications
PRODUCT_PACKAGES += \
    server_sdv_sample \
    client_sdv_sample \
    server_rust_sdv_sample \
    client_rust_sdv_sample \
    server_rust_tokio_sdv_sample \
    client_rust_tokio_sdv_sample \
    com.android.sdv.samples.rpc \
    lifecycle_sample \
    logging_sdv_sample \
    structured_logging_sdv_sample \
    compile_time_log_filtering_sdv_sample \
    log_filtering_sdv_sample \
    logging_sdv_rust_sample \
    tracing_sdv_rust_sample \
    com.android.sdv.samples.rochambeau \
    service_authn_sample_rs \
    client_sdv_benchmark_sample \
    sdv_poc \
    sdv_poc_client \
    com.android.sdv.hello.apex \
    dt_agent \
    libsdv_dt \
    dt_sample_client_cpp \
    client_some_ip_sdv_sample \

# SDV telemetry service executables
PRODUCT_PACKAGES += \
    sdv_telemetry_service \
    telemetry_cpp_client \
    telemetry_rust_client \

# Enable tracing on userdebug and eng
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Set the property for the system partition.
PRODUCT_SYSTEM_PROPERTIES += \
    persist.traced.enable=1
endif

# Perfetto packages for tracing
PRODUCT_PACKAGES_DEBUG += \
    perfetto \
    traced \
    traced_probes \
