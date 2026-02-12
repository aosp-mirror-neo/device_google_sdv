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

# Modules to be included in the performance benchmarking images.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_PERF_PACKAGES = \
    com.android.sdv.performance.unit_type_owner \
    performance.hm.config \
    performance_custom_mode_dispatcher \
    com.android.sdv.performance.apex0 \
    com.android.sdv.performance.apex1 \
    com.android.sdv.performance.apex2 \
    com.android.sdv.performance.apex3 \
    com.android.sdv.performance.apex4 \
    com.android.sdv.performance.apex5 \
    com.sdv.someip \
    libhealth_vsidl_with_bp_file-vsidl-config.binpb \
    sdv_vsomeip_vehicle_health_monitor_sample_target \
    test_vm_health_subscriber \
    com.android.sdv.sample.bar \
    com.android.sdv.sample.baz \
    com.android.sdv.sample.foo \
    com.android.sdv.sample.qux \
    cujs_orchestration_configurations \
    hm_config_with_someip.textproto \
    hm_config_without_someip.textproto

PRODUCT_PACKAGES += $(SDV_PERF_PACKAGES)
