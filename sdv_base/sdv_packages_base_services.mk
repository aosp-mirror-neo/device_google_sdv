# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# SDV base packages required to be installed into the target are placed here.
# These include any SDV components that are required for an Android based target
# (including SDV Core) to work with other SDV targets (eg: as VMs in a multi-VM
# environment). Currently this comprises of the SDV specific connectivity
# components (vsock, ipv4, etc.). SDV Comms stack components (SDV Service
# Discovery, Data Tunnel, etc., with the exception of agents, which are included
# starting from sdv_core_base).

ifeq ($(SDV_VM_LEVEL_PERMISSIONS_MODULE),)
  $(error $$SDV_VM_LEVEL_PERMISSIONS_MODULE is not set, so no VM level permissions will be installed. \
    For a properly working Authz permissions, make sure that an implementation will be installed!)
endif

# TODO: b/415334868 - Investigate/prune the list SDV_BASE_SERVICES_PACKAGES.
# It is possible that some of these items might not be actually needed in IVI
SDV_BASE_SERVICES_PACKAGES += \
    sdv_dt_agent_acl_textproto \
    libsdv_authz_policy \
    libsdv_comms_ctx_ffi \
    libsdv_comms_ctx_impl \
    libsdv_comms_dt \
    libsdv_comms_dt_ffi \
    libsdv_comms_id \
    libsdv_comms_id_ffi \
    libsdv_comms_sd \
    libsdv_comms_sd_ffi \
    libsdv_dt_core \
    libsdv_status \
    $(SDV_VM_LEVEL_PERMISSIONS_MODULE)

# Command line tools to help with development and manual testing.
SDV_BASE_SERVICES_HOST_PACKAGES += \
    sdv-cf \
    sdv-avb-lock \
    sdv-provision-dev-mesh \
    vvmconfig_generator \

PRODUCT_PACKAGES += $(SDV_BASE_SERVICES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_BASE_SERVICES_HOST_PACKAGES)
