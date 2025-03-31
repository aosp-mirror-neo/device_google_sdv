# Copyright 2023-2024 Google LLC
#
# All the samples from platform/.
#
# These are not included in sdv_core_base.mk. Targets need to include them explicitly.

SDV_PLATFORM_SAMPLES_PACKAGES += \
    sdv.brand_new_apex.config

SDV_PLATFORM_HOST_SAMPLES_PACKAGES +=

PRODUCT_PACKAGES += $(SDV_PLATFORM_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_PLATFORM_HOST_SAMPLES_PACKAGES)
