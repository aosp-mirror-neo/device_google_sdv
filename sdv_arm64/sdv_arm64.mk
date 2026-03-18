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

# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# sdv_arm64 defines reusable elements specific to the SDV Core arm64 target.
#
# Note: it should not be used in IVI targets. It contains elements that, for
# example, configure network interfaces - which in IVI a part handled by
# NetworkManager.

PRODUCT_PACKAGES += \
    dlkm_loader \
    tcpdump

# Preprovisioned vvmtruststore content for /system_ext/etc/.
# Used until properly mounting a vvmtruststore partition on arm64 is supported.
# TODO: b/371522021 - configure the vvmtruststore partition on the test hardwares and remove these
#       packages.
PRODUCT_PACKAGES += \
    vvmtruststore_instance1_etc_uds_certs \
    vvmtruststore_instance1_etc_uds_pubs \
    vvmtruststore_instance2_etc_uds_certs \
    vvmtruststore_instance2_etc_uds_pubs \
    vvmtruststore_instance3_etc_uds_certs \
    vvmtruststore_instance3_etc_uds_pubs

PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.sdv_arm64.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet.sdv_arm64.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_core_arm64/ethernet/ethernet.sdv_arm64.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/hw/ethernet.sdv_arm64.rc

# vvmtruststore mounting logic
PRODUCT_PACKAGES += vvmtruststore.rc
