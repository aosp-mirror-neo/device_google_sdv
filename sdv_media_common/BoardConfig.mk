# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

# Based on device/google/trout/shared/BoardConfig.mk
# device/google/cuttlefish/shared/graphics/BoardConfig.mk
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/google/sdv/sdv_media_common/sepolicy \
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
