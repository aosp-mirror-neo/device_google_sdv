# Copyright 2023 Google LLC

# Put here the common configurations between all SDV core targets:
# * sdv_core_arm64
# * sdv_core_cf

# SDV's BoardConfig includes and extends minidroid/BoardConfig.mk. Before including it, we must
# set a few variables which serve as parameters for minidroid/BoardConfig.mk.
# Overwrite androidboot.hardware in minidroid/BoardConfig.mk.
LOCAL_ANDROIDBOOT_HARDWARE := sdv
# Overwrite androidboot.init_rc in minidroid/BoardConfig.mk, and set SDV's init .rc script as the
# primary one which is loaded first by the init process.
# WARNING: the side-effect of specifying this property is that the init .rc files under
# /{system,system_ext,vendor,odm,product}/etc/init/ are no longer imported automatically by the
# init process, and they have to be explicitly imported from the primary init .rc file of SDV.
LOCAL_ANDROIDBOOT_INIT_RC := /system/etc/init/hw/init.sdv.rc
include device/google/cuttlefish/shared/minidroid/BoardConfig.mk

# Defining the SEPolicies of the SDV packages located on the system_ext partition by amending the
# private and public policies of the partition. See system/sepolicy/README.md for more details.
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
BOARD_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/vendor/google/

BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

TARGET_AVB_SYSTEM_EXT_HASHTREE_ALGORITHM ?= sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm $(TARGET_AVB_SYSTEM_HASHTREE_ALGORITHM)

# Extend the vbmeta_system.img from minidroid (which already contains the hashtree metadata of
# system) with system_ext's hashtree metadata.
BOARD_AVB_VBMETA_SYSTEM += system_ext
# Add system_ext to the super.img from minidroid which already contains system and vendor.
BOARD_GOOGLE_SYSTEM_DYNAMIC_PARTITIONS_PARTITION_LIST += system_ext

BOARD_USERDATAIMAGE_PARTITION_SIZE := 134217728 # 128 MiB
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

ifneq ($(SDV_PREBUILT),true)
    # HOST_OUT is empty, so we cannot use it. See $(warning HOST_OUT is $(HOST_OUT)).
    host_out_dir := $(OUT_DIR)/host/linux-x86
    # Output sdv_proxy.zip to the out/dist/ directory when make dist is run. This way sdv_proxy.zip will
    # also be available as a downloadable artifact when an SDV target is built remotely.
    $(call dist-for-goals, dist_files, $(host_out_dir)/sdv_proxy.zip)
endif
