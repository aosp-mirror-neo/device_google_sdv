# Copyright 2024 Google LLC
#
# Sample packages for SDV base components.
#
# They are not included by sdv_base.mk, only by downstream targets.

SDV_BASE_SERVICES_SAMPLES_PACKAGES += \
    sdv_comms_client_rs \
    sdv_comms_dt_probe_rs \
    sdv_comms_sample_rpc_client_rs \
    sdv_comms_sample_rpc_server_rs \
    sdv_dt_publisher_cpp \
    sdv_dt_subscriber_cpp \
    sdv_mw_cluster_server \
    sdv_mw_cluster_client \
    sdv_mw_sunroof_client \
    sdv_mw_tpms_server \
    sdv_mw_tpms_client \
    sdv_provisioning_tool \
    sdv_user_preferences_client_cpp \
    sdv_vsidl_provider_query \
    vvmconfig.example \

SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES)
