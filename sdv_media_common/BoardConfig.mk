# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

# device/google/trout/shared/BoardConfig.mk
include device/google/cuttlefish/shared/graphics/BoardConfig.mk
include device/google/cuttlefish/shared/swiftshader/BoardConfig.mk
include device/google/cuttlefish/shared/virgl/BoardConfig.mk

# device/google/cuttlefish/shared/BoardConfig.mk
BOARD_VENDOR_SEPOLICY_DIRS += device/google/cuttlefish/shared/sepolicy/vendor
BOARD_VENDOR_SEPOLICY_DIRS += device/google/cuttlefish/shared/sepolicy/vendor/google

# Enable goldfish's encoder.
# TODO(b/113617962) Remove this if we decide to use
# device/generic/opengl-transport to generate the encoder
BUILD_EMULATOR_OPENGL_DRIVER := true
BUILD_EMULATOR_OPENGL := true

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio-gpu.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(KERNEL_MODULES_PATH)/virtio_snd.ko
