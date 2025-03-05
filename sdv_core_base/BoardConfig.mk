# Copyright 2023-2024 Google LLC

# Put here the common configurations between all SDV core targets:
# * sdv_core_arm64
# * sdv_core_cf

LOCAL_ANDROIDBOOT_HARDWARE := sdv

TARGET_KERNEL_USE ?= 6.6
TARGET_KERNEL_ARCH ?= $(TARGET_ARCH)
TARGET_KERNEL_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)/kernel-$(TARGET_KERNEL_USE)
SYSTEM_DLKM_SRC ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
KERNEL_MODULES_PATH ?= \
    kernel/prebuilts/common-modules/virtual-device/$(TARGET_KERNEL_USE)/$(subst _,-,$(TARGET_KERNEL_ARCH))
PRODUCT_COPY_FILES += $(TARGET_KERNEL_PATH):kernel

# Usually, only modules installed to system_dlkm don't get stripped during
# build. Stripping kernel modules removes their signature, and unsigned modules
# are subject to additional restrictions on what symbols those modules can
# expose.
#
# Without setting this, virtio_pci_modern_dev.ko on arm64 fails to load due to
#
#   virtio_pci_modern_dev: exports protected symbol vp_modern_config_vector
#
# Which causes the device to boot-loop.
BOARD_DO_NOT_STRIP_VENDOR_RAMDISK_MODULES := true

# The list of modules strictly/only required either to reach second stage
# init, OR for recovery. Do not use this list to workaround second stage
# issues.
#
# Depending on the specific module, they may exist under $(KERNEL_MODULES_PATH)
# or $(SYSTEM_DLKM_SRC). virtio_blk.ko, virtio_console.ko, virtio_pci.ko,
# virtio_pci_modern_dev.ko and vmw_vsock_virtio_transport.ko were added to
# $(SYSTEM_DLKM_SRC) in May 2024, but remained in $(KERNEL_MODULES_PATH) until
# Nov 2024, so including both with $(wildcard) just causes a build error before
# the next prebuilts drop.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES = \
    $(KERNEL_MODULES_PATH)/failover.ko \
    $(KERNEL_MODULES_PATH)/net_failover.ko \
    $(KERNEL_MODULES_PATH)/virtio-rng.ko \
    $(KERNEL_MODULES_PATH)/virtio_net.ko \

ifeq ($(TARGET_KERNEL_USE), 6.1)
EXTRA_KERNEL_MODULES_PATH := $(KERNEL_MODULES_PATH)
else
EXTRA_KERNEL_MODULES_PATH := $(SYSTEM_DLKM_SRC)
endif

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
    $(EXTRA_KERNEL_MODULES_PATH)/virtio_blk.ko \
    $(EXTRA_KERNEL_MODULES_PATH)/virtio_console.ko \
    $(EXTRA_KERNEL_MODULES_PATH)/virtio_pci.ko \
    $(EXTRA_KERNEL_MODULES_PATH)/virtio_pci_legacy_dev.ko \
    $(EXTRA_KERNEL_MODULES_PATH)/virtio_pci_modern_dev.ko \
    $(EXTRA_KERNEL_MODULES_PATH)/vmw_vsock_virtio_transport.ko

# GKI >6.4 will have an required vmw_vsock_virtio_transport_common.ko and vsock.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
    $(wildcard $(KERNEL_MODULES_PATH)/vmw_vsock_virtio_transport_common.ko) \
    $(wildcard $(KERNEL_MODULES_PATH)/vsock.ko)

TARGET_NO_RECOVERY := true

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := \
    device/google/sdv/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_OPTIONS_FILE := \
    device/google/cuttlefish/shared/config/first_stage_modules.options

TARGET_BOOTLOADER_BOARD_NAME := cutf

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Disable sparse on all filesystem images
# This will prevent sparsing of super.img
TARGET_USERIMAGES_SPARSE_EROFS_DISABLED ?= true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED ?= true
TARGET_USERIMAGES_SPARSE_F2FS_DISABLED ?= true

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem

BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 3

BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_MALLOC_ALIGNMENT := 16

BOARD_USES_GENERIC_KERNEL_IMAGE := true

PRODUCT_COPY_FILES += \
    device/google/cuttlefish/dtb.img:dtb.img \
    device/google/cuttlefish/required_images:required_images \

BOARD_BOOTLOADER_IN_UPDATE_PACKAGE := true
BOARD_RAMDISK_USE_LZ4 := true

BOARD_KERNEL_CMDLINE += printk.devkmsg=on
BOARD_KERNEL_CMDLINE += audit=1
BOARD_KERNEL_CMDLINE += panic=-1
BOARD_KERNEL_CMDLINE += 8250.nr_uarts=1
BOARD_KERNEL_CMDLINE += cma=0
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/etc/
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += init=/init
BOARD_BOOTCONFIG += androidboot.hardware=$(LOCAL_ANDROIDBOOT_HARDWARE)
BOARD_BOOTCONFIG += \
    androidboot.init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC)
# TODO(b/398294139): Restore the value to 16KiB after the issue is resolved.
BOARD_BOOTCONFIG += \
    kernel.vmw_vsock_virtio_transport_common.virtio_transport_max_vsock_pkt_buf_size=4096
BOARD_BOOTCONFIG += \
    androidboot.microdroid.debuggable=1 \
    androidboot.adb.enabled=1

BOARD_BOOTCONFIG += \
    androidboot.sdv.telemetry.enabled=1

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor system_ext product vendor_dlkm
# reserve 512+256+128MiB for dynamic partition metadata
BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE := 939524096
# coverage builds use more space, add 270MiB more
ifeq ($(CLANG_COVERAGE),true)
  BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE := \
    $(shell expr $(BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE) + 283115520)
endif

# performance build requires more space for pubsub functionality, add 512MiB more
ifeq ($(SDV_CORE_PERF_IMAGE),true)
  BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE := \
    $(shell expr $(BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE) + 536870912)
endif

# The super partition is sized to 2*dynamic partition size + overhead.
# Double dynamic parititon accounts for A/B slots for updates.
# Overhead is 4 MiB as recommended in
# https://source.android.com/docs/core/ota/dynamic_partitions/implement#dyanimic-partitions-sizing
BOARD_SUPER_PARTITION_SIZE := \
  $(shell expr 2 \* $(BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_SIZE) + 4 \* 1024 \* 1024)

BOARD_SUPER_PARTITION_GROUPS := google_system_dynamic_partitions
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

BOARD_VENDOR_SEPOLICY_DIRS += device/google/cuttlefish/shared/sepolicy/vendor/seriallogging

# Defining the SEPolicies of the SDV packages located on the system_ext partition by amending the
# private and public policies of the partition. See system/sepolicy/README.md for more details.
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/private
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/system_ext/public
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/system_ext/public
PRODUCT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/product/private
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_base/sepolicy/vendor
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_base/sepolicy/vendor/

BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# 100 MiB is the minimum free space in userdata partition for checkpoint creation.
# ~175MiB of free space is required in userdata partition to upload system updates.
# A total of 275MB of free space is needed.
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912 # 512 MiB
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

# The /metadata partition is required for metadata encryption
BOARD_USES_METADATA_PARTITION := true

# Vendor DLKM partition
# https://source.android.com/docs/core/architecture/partitions/vendor-odm-dlkm-partition
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Add VLAN support (provided by 8021q module)
TARGET_KERNEL_MODULES_PATH ?= kernel/prebuilts/$(TARGET_KERNEL_USE)/$(TARGET_KERNEL_ARCH)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(TARGET_KERNEL_MODULES_PATH)/8021q.ko

# HOST_OUT is empty, so we cannot use it. See $(warning HOST_OUT is $(HOST_OUT)).
host_out_dir := $(OUT_DIR)/host/linux-x86

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
  vbmeta \
  vendor_dlkm \

BOARD_ROOT_EXTRA_FOLDERS := vvmtruststore

# "m custom_images" must be called for that image to be created.
PRODUCT_CUSTOM_IMAGE_MAKEFILES += \
  device/google/sdv/sdv_base/vvmtruststore.mk

# Have SD Agent on SDV read ACL file mappings from Service Bundle Registry
$(call soong_config_set,sdv_authz,acl_provider_type,sdv_acl_provider)
