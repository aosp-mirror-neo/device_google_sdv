# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

# Note: include order matters, sdv_media may need to override some of the
# settings defined in core.
include device/google/sdv/sdv_core_cf/BoardConfig.mk
include device/google/sdv/sdv_media_common/BoardConfig.mk

# virtio-gpu.ko depends on symbols defined in virtio_dma_buf.ko. Without this,
# sdv_media_cf fails to boot.
#
# We can't put it in sdv_media_common/BoardConfig.mk, because we end up with
# duplicated entry for sdv_media_arm64:
# * one from sdv_media_common,
# * one from sdv_core_arm64 which requires virtio_dma_buf.ko even without
#   virtio-gpu.
# The build system doesn't allow this, so we put the dependency in the
# Cuttlefish-specific BoardConfig.mk instead.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_dma_buf.ko
