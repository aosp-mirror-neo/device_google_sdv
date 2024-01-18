# Copyright 2023 Google LLC
#
# All the packages in telemetry/ required to be installed into the target
# or made available to the host are placed here.
#
# There are three variables to distinguish samples, packages and host packages.

SDV_TELEMETRY_PACKAGES = \
    sdv_telemetry_service_agent

SDV_TELEMETRY_SAMPLE_PACKAGES = \
    telemetry_cpp_client \
    telemetry_rust_c_client \
    telemetry_sample_publisher \
    dt_telemetry_sample_publisher

SDV_TELEMETRY_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_TELEMETRY_PACKAGES) $(SDV_TELEMETRY_SAMPLE_PACKAGES)

ifneq ($(SDV_PREBUILT),true)
    PRODUCT_HOST_PACKAGES += $(SDV_TELEMETRY_HOST_PACKAGES)
endif
