# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Define an alias for the kernel image as it doesn't
# have a suffix by default, but we require a .img
# suffix to include it in RADIO images
KERNEL_IMG_ALIAS := $(PRODUCT_OUT)/kernel.img

$(KERNEL_IMG_ALIAS): $(PRODUCT_OUT)/kernel
	@echo "Creating kernel.img alias for packaging"
	$(hide) ln -sf $(notdir $<) $@

# Utilizing RADIO to copy files into
# <product>-img.zip, see definition of
# INSTALLED_RADIOIMAGE_TARGET in build/make/core/Makefile
# Requires BOARD_PACK_RADIOIMAGES in BoardConfig.mk
INSTALLED_RADIOIMAGE_TARGET += \
	$(PRODUCT_OUT)/vendor_ramdisk.img \
	$(PRODUCT_OUT)/vendor-bootconfig.img \
	$(KERNEL_IMG_ALIAS)
