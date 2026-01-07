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

# This is usually set by sdv_core_base/BoardConfig (through
# sdv_core_cf/BoardConfig.mk), but we want to add media-specific init logic on
# top of that one. Because we set this everywhere with ?=, the first definition
# applies. We need to make sure this is set before sdv_core_cf/BoardConfig.mk.
#
# TODO: b/267320398 - clean this up once automatic importing of .rc files from
# /etc/init/ works.
LOCAL_ANDROIDBOOT_INIT_RC ?= /system/etc/init/hw/init.sdv_media_cf.rc

# Note: include order matters, sdv_media may need to override some of the
# settings defined in core.
include device/google/sdv/sdv_core_cf/BoardConfig.mk
include device/google/sdv/sdv_media_base/BoardConfig.mk

# virtio-gpu.ko depends on symbols defined in virtio_dma_buf.ko. Without this,
# sdv_media_cf fails to boot.
#
# We can't put it in sdv_media_base/BoardConfig.mk, because we end up with
# duplicated entry for sdv_media_arm64:
# * one from sdv_media_base,
# * one from sdv_core_arm64 which requires virtio_dma_buf.ko even without
#   virtio-gpu.
# The build system doesn't allow this, so we put the dependency in the
# Cuttlefish-specific BoardConfig.mk instead.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_dma_buf.ko

# Until Cuttlefish supports multiple virtualized audio devices via virtio-snd,
# we capture audio from 6 loopback devices, downmix it and forward to a single
# 2-channel virtio-snd backend device.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/snd-aloop.ko
# Create 6 loopback devices. Each entry creates a pair of them, so we only need 3.
BOARD_KERNEL_CMDLINE += snd_aloop.enable=1,1,1,1

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_media_cf/sepolicy/system_ext/private
