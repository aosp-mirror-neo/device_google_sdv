# Copyright 2024 Google LLC

# SDV base packages required to be installed into the target are placed here.
# These include any SDV components that are required for an Android based target
# (including SDV Core) to work with other SDV targets (eg: as VMs in a multi-VM
# environment). Currently this comprises of the SDV specific connectivity
# components (vsock, ipv4, etc.) SDV Comms stack components (SDV Service
# Discovery, Data Tunnel, etc.).

SDV_BASE_SERVICES_PACKAGES = \
    dt_agent \
    libsdv_authn \
    libsdv_authz_policy \
    libsdv_comms_ctx_ffi \
    libsdv_comms_ctx_impl \
    libsdv_comms_dt \
    libsdv_comms_dt_ffi \
    libsdv_comms_id \
    libsdv_comms_id_ffi \
    libsdv_comms_rpc \
    libsdv_comms_sd \
    libsdv_comms_sd_ffi \
    libsdv_dt \
    libsdv_dt_core \
    libsdv_dt_rust \
    libsdv_sd \
    libsdv_sd_rs \
    libsdv_status \
    rpcagent \
    sdv_sd_agent \
    sdv_sd_cli \
    vsock_local_cid \

SDV_BASE_SERVICES_HOST_PACKAGES =

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_PACKAGES)
