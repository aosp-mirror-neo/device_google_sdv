# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

# Based on device/google/trout/shared/BoardConfig.mk
# device/google/cuttlefish/shared/graphics/BoardConfig.mk
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/google/sdv/sdv_media_base/sepolicy \
    external/minigbm/cros_gralloc/sepolicy

# Bumping userdata partition size to simplify development of apps (Harry) on SDV Media.
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912 # 512 MiB

# Enable goldfish's encoder.
# TODO(b/113617962) Remove this if we decide to use
# device/generic/opengl-transport to generate the encoder
BUILD_EMULATOR_OPENGL_DRIVER := true
BUILD_EMULATOR_OPENGL := true

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio-gpu.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_snd.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/v4l2loopback.ko

# Soong build flags that remove the GLES/Vulkan libraries dependency on the
# full Android graphics stack and enable support for setting up the rendering
# context based on externally allocated (with minigbm) GPU buffers.
#
# These are custom modification to the graphics libraries, made specifically
# for SDV in order to minimize the time from boot to first frame by bypassing
# Android graphics stack.
#
# Build ANGLE OpenGL in DMA-BUF-enabled mode. This makes ANGLE use Vulkan as
# the backend implementation for EGL, and adds support for
# EGL_EXT_image_dma_buf_import extension.
$(call soong_config_set,angle,angle_android_dma_buf,true)
# Build gfxstream Vulkan in "surfaceless" mode. This enables support for
# VK_EXT_external_memory_dma_buf and VK_EXT_image_drm_format_modifier
# extensions, necessary for rendering to a DMA-BUF backed by host GPU memory.
$(call soong_config_set,gfxstream,mesa3d_platforms,none)
