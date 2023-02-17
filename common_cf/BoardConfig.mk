# The common board config for every SDV lunch target for Cuttlefish.

TARGET_BOARD_PLATFORM := vsoc_x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_ABI := x86_64

# As of now we inherit the whole board config from minidroid
-include device/google/cuttlefish/shared/minidroid/BoardConfig.mk
