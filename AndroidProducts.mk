# Copyright 2024 Google LLC

# Format of PRODUCT_MAKEFILES:
# <product_name>:<path_to_the_product_makefile>
# If the "<product_name>:" part is omitted, then the product name will be the base file name
# (without dir and the .mk suffix) of the product makefile.
# Where product_name is the product name, appearing, for instance, in the build fingerprint and
# as the ro.product.name Android property.
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/sdv_core_cf/sdv_core_cf.mk \
    $(LOCAL_DIR)/sdv_media_cf/sdv_media_cf.mk \
    $(LOCAL_DIR)/sdv_ivi_cf/sdv_ivi_cf.mk

COMMON_LUNCH_CHOICES := \
    sdv_core_cf-trunk_staging-userdebug \
    sdv_media_cf-trunk_staging-userdebug \
    sdv_ivi_cf-trunk_staging-userdebug
