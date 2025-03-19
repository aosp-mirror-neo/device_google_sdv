# Copyright 2024 Google LLC

# SDV base packages required to be installed into the target are placed here.
# These include any SDV components that are required for an Android based target
# (including SDV Core) to work with other SDV targets (eg: as VMs in a multi-VM
# environment). Currently this comprises of the SDV specific connectivity
# components (vsock, ipv4, etc.) SDV Comms stack components (SDV Service
# Discovery, Data Tunnel, etc.).

SDV_BASE_SERVICES_PACKAGES += \
    dt_agent \
    sdv_dt_agent_acl_textproto \
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
    libsdv_dt_core \
    libsdv_status \
    rpcagent \
    sdv_sd_agent \
    vsock_local_cid \

# The packages that provide the Android DICE chain for the SDV Mesh. Either init_open_dice or
# init_open_dice_from_file and the associated files.
ifeq ($(SDV_OPEN_DICE_PROVIDER_PACKAGES),)
  $(error $$SDV_OPEN_DICE_PROVIDER_PACKAGES not set)
endif
SDV_BASE_SERVICES_PACKAGES += $(SDV_OPEN_DICE_PROVIDER_PACKAGES)

# Command line tools to help with development and manual testing.
SDV_BASE_SERVICES_HOST_PACKAGES += \
    sdv-cf \
    sdv-avb-lock \
    sdv-provision-dev-mesh \
    vvmconfig_generator \

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_PACKAGES)
