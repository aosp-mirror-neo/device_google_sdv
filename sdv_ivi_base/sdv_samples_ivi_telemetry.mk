# Copyright 2024 Google LLC
#
# All the samples in telemetry/ required to be installed into the IVI target
# or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.

SDV_IVI_TELEMETRY_SAMPLES_PACKAGES += \
    telemetry_rust_c_client \
    telemetry_sample_publisher \
    telemetry_sample_getter_publisher \
    sdv_ivi_telemetry_simulator \
    telemetry_java_sample_ivi_publisher \
    telemetry_java_sample_ivi_publisher_prod \
    telemetry_java_sdk_sample_ivi_publisher \
    TelemetryJavaClientApp

SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_IVI_TELEMETRY_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES)

$(call soong_config_set, sdv_config, SDV_IVI_TELEMETRY_SAMPLES_PACKAGES, $(SDV_IVI_TELEMETRY_SAMPLES_PACKAGES))
$(call soong_config_set, sdv_config, SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES, $(SDV_IVI_TELEMETRY_HOST_SAMPLES_PACKAGES))
