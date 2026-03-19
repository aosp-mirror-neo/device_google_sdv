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

# All the packages in telemetry/ required to be installed into the IVI target
# or made available to the host are placed here.
#
# Note: Different binaries/packages are needed on SDV_IVI vs SDV_Core targets
# given SDV Runtime on IVI is currently not supported.

SDV_IVI_TELEMETRY_PACKAGES += \
    sdv_ivi_telemetry_service_agent

SDV_IVI_TELEMETRY_HOST_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_IVI_TELEMETRY_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_TELEMETRY_HOST_PACKAGES)

PRODUCT_COPY_FILES += \
    device/google/sdv/sdv_ivi_base/sdv.telemetry.rc:${TARGET_COPY_OUT_VENDOR}/etc/init/sdv.telemetry.rc \

$(call soong_config_set, sdv_config, SDV_IVI_TELEMETRY_PACKAGES, $(SDV_IVI_TELEMETRY_PACKAGES))
$(call soong_config_set, sdv_config, SDV_IVI_TELEMETRY_HOST_PACKAGES, $(SDV_IVI_TELEMETRY_HOST_PACKAGES))
