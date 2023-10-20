# Copyright 2023-2024 Google LLC

# Put here the common configurations between all SDV core targets:
# * sdv_core_arm64
# * sdv_core_cf

# SDV's BoardConfig includes and extends minidroid/BoardConfig.mk. Before including it, we must
# set a few variables which serve as parameters for minidroid/BoardConfig.mk.
# Overwrite androidboot.hardware in minidroid/BoardConfig.mk.
LOCAL_ANDROIDBOOT_HARDWARE := sdv

include device/google/cuttlefish/shared/minidroid/BoardConfig.mk

# Defining the SEPolicies of the SDV packages located on the system_ext partition by amending the
# private and public policies of the partition. See system/sepolicy/README.md for more details.
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/

BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

TARGET_AVB_SYSTEM_EXT_HASHTREE_ALGORITHM ?= sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += \
  --hash_algorithm $(TARGET_AVB_SYSTEM_EXT_HASHTREE_ALGORITHM)

BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

TARGET_AVB_PRODUCT_HASHTREE_ALGORITHM ?= sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += \
  --hash_algorithm $(TARGET_AVB_PRODUCT_HASHTREE_ALGORITHM)

# Extend the vbmeta_system.img from minidroid (which already contains the hashtree metadata of
# system) with system_ext's and product's hashtree metadata.
BOARD_AVB_VBMETA_SYSTEM += system_ext product
# Add system_ext and product to the super.img from minidroid which already contains system and
# vendor.
BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_PARTITION_LIST += system_ext product

# Size defined in device/google/cuttlefish/shared/minidroid/BoardConfig.mk (256MB) is too small to
# for SDV. Increase it to 512MB.
BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE := 536870912

# The super partition is sized to 2*dynamic partition size + overhead.
# Double dynamic parititon accounts for A/B slots for updates.
# Overhead is 4 MiB as recommended in
# https://source.android.com/docs/core/ota/dynamic_partitions/implement#dyanimic-partitions-sizing
BOARD_SUPER_PARTITION_SIZE := 1077936128

BOARD_USERDATAIMAGE_PARTITION_SIZE := 134217728 # 128 MiB
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

# The /metadata partition is required for metadata encryption
BOARD_USES_METADATA_PARTITION := true

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko

# HOST_OUT is empty, so we cannot use it. See $(warning HOST_OUT is $(HOST_OUT)).
host_out_dir := $(OUT_DIR)/host/linux-x86
# Output sdv_proxy.zip to the out/dist/ directory when make dist is run. This way sdv_proxy.zip will
# also be available as a downloadable artifact when an SDV target is built remotely.
$(call dist-for-goals, dist_files, $(host_out_dir)/sdv_proxy.zip)

# A/B update support
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
  boot \
  init_boot \
  vendor_boot \
  system \
  system_ext \
  product \
  vbmeta_system \
  vendor \
  vbmeta
