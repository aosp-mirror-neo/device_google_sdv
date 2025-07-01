# Copyright 2025 Google LLC

# Makes the vvmtruststore image installed to the $OUT directory on build and included in the
# sdv_*-img-*.zip on disting.
BOARD_CUSTOMIMAGES_PARTITION_LIST += \
  vvmtruststore_preprovisioned_instance1 \
  vvmtruststore_preprovisioned_instance2 \
  vvmtruststore_preprovisioned_instance3

# Must tell the build system where to find the build artifact of the vvmtruststore image.
ifeq ($(CLANG_COVERAGE),true)
  VARIANT_DIR = android_common_cov
else
  VARIANT_DIR = android_common
endif

# Pre-provisioned vvmstruststore images for ease of testing.
# Must tell the build system where to find the build artifacts of the images.
VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR := \
  $(OUT_DIR)/soong/.intermediates/device/google/sdv/vvmtruststore_preprovisioned

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE1_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance1/$(VARIANT_DIR)/vvmtruststore_preprovisioned_instance1.img

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE2_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance2/$(VARIANT_DIR)/vvmtruststore_preprovisioned_instance2.img

BOARD_VVMTRUSTSTORE_PREPROVISIONED_INSTANCE3_IMAGE_LIST := \
  $(VVMTRUSTSTORE_PREPROVISIONED_INTERMEDIATE_DIR)/vvmtruststore_preprovisioned_instance3/$(VARIANT_DIR)/vvmtruststore_preprovisioned_instance3.img
