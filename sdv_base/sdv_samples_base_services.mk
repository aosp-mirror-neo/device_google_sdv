# Copyright 2024 Google LLC
#
# Sample packages for SDV base components.
#
# They are not included by sdv_base.mk, only by downstream targets.

SDV_BASE_SERVICES_SAMPLES_PACKAGES = \
    dt_comms_client_cpp \
    sdv_cluster_grpc_client_cpp \
    sdv_cluster_grpc_server_cpp \
    sdv_comms_client_rs \
    sdv_comms_dt_probe_rs \
    sdv_comms_sample_dt_rs \
    sdv_comms_sample_rpc_client_rs \
    sdv_comms_sample_rpc_server_rs \
    sdv_dt_publisher_cpp \
    sdv_dt_publisher_cpp_acl_textproto \
    sdv_dt_subscriber_cpp \
    sdv_sample_rpc_client \
    sdv_sample_rpc_server \
    sdv_sunroof_grpc_client_cpp \
    sdv_tpms_grpc_client_cpp \
    sdv_tpms_grpc_server_cpp \
    sdv_user_preferences_client_cpp \
    service_authn_sample_bench \
    service_authn_sample_rs \
    vvmconfig.example \
    sdv_vsidl_provider_query \

SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_SAMPLES_PACKAGES)
