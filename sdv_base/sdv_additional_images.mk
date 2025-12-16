# Copyright 2025 Google LLC

# Utilizing RADIO to copy files into
# <product>-img.zip, see definition of
# INSTALLED_RADIOIMAGE_TARGET in build/make/core/Makefile
# Requires BOARD_PACK_RADIOIMAGES in BoardConfig.mk
INSTALLED_RADIOIMAGE_TARGET += \
	$(PRODUCT_OUT)/vendor_ramdisk.img \
	$(PRODUCT_OUT)/vendor-bootconfig.img
