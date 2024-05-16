# Copyright 2024 Google LLC
#
# SDV base packages required to be installed into the target are placed here.
# These include any SDV components that are required for an Android based target
# (including SDV Core) to work with other SDV targets (eg: as VMs in a multi-VM
# environment). Currently this comprises of the SDV specific connectivity
# components (vsock, ipv4, etc.) and samples and the SDV Comms stack components
# (SDV Service Discovery, Data Tunnel, etc.) and samples.
#
# There are two variables to distinguish device samples and services.

SDV_BASE_SERVICES_PACKAGES = \
    dt_agent \
    libsdv_authn \
    libsdv_authz \
    libsdv_dt_core \
    libsdv_dt \
    libsdv_dt_rust \
    libsdv_sd \
    libsdv_sd_rs \
    rpcagent \
    sdv_mesh_agent \
    sdv_sd_agent \
    sdv_sd_cli \
    vsock_local_cid \
    vvm_config.textproto \

SDV_BASE_SERVICES_SAMPLES_PACKAGES = \
    dt_sample_client_cpp \
    dt_sample_publisher_rust \
    dt_sample_subscriber_rust \
    sdv_cluster_grpc_client_cpp \
    sdv_cluster_grpc_server_cpp \
    sdv_grpc_client \
    sdv_grpc_server \
    sdv_sample_multivd_ipv4_server \
    sdv_sample_multivd_ipv4_client \
    sdv_sample_multivd_vsock_client \
    sdv_sample_multivd_vsock_server \
    sdv_sample_rpc_client \
    sdv_sample_rpc_server \
    sdv_tpms_grpc_client_cpp \
    sdv_tpms_grpc_server_cpp \
    service_authn_sample_bench \
    service_authn_sample_rs \

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_PACKAGES) $(SDV_BASE_SERVICES_SAMPLES_PACKAGES)
