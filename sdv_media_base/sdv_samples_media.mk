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

# All the SDV Media samples.
#
# These are not included in sdv_media_base.mk. Targets need to include them explicitly.

# Audio samples
SDV_MEDIA_SAMPLES_PACKAGES = \
    tinyplay2 \
    tinymix2 \
    tinycap2 \

# Sample application that renders to multiple displays.
SDV_MEDIA_SAMPLES_PACKAGES += \
    sdv_multi_display_sample_rust \
    sdv_gl_gen_texture \
    sdv_screencap \

# Sample mixer control CLI
SDV_MEDIA_SAMPLES_PACKAGES += mixerctl

SDV_MEDIA_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_MEDIA_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_MEDIA_HOST_SAMPLES_PACKAGES)
