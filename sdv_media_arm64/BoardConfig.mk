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

# SDV Media specific board config shall go into this file.

LOCAL_ANDROIDBOOT_INIT_RC ?= /system/etc/init/hw/init.sdv_media.rc

# Note: include order matters, sdv_media may need to override some of the
# settings defined in core.
include device/google/sdv/sdv_core_arm64/BoardConfig.mk
include device/google/sdv/sdv_media_base/BoardConfig.mk
