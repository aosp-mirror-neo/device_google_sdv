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

# The rules that install the SDV sample network configuration script for all lunch targets that
# need to communicate with the SDV system using SDV communications stack

PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_sd_mesh.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_sd_mesh.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_sdv_dt.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_sdv_dt.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_sdv_rpc.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_sdv_rpc.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_namespace_setup.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_namespace_setup.sh
