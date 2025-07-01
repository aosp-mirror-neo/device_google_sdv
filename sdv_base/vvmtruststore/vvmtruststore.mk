# Copyright 2025 Google LLC

BOARD_ROOT_EXTRA_FOLDERS += vvmtruststore

# Makes the vvmtruststore image installed to the $OUT directory on build and included in the
# sdv_core_*-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += vvmtruststore

# Must tell the build system where to find the build artifact of the vvmtruststore image.
ifeq ($(CLANG_COVERAGE),true)
  VARIANT_DIR = android_common_cov
else
  VARIANT_DIR = android_common
endif
BOARD_VVMTRUSTSTORE_IMAGE_LIST := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/sdv_base/vvmtruststore/vvmtruststore/$(VARIANT_DIR)/vvmtruststore.img

# The vvmtruststore partition is owned by the framework i.e. system(_ext).
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_base/vvmtruststore/sepolicy/vvmtruststore/private