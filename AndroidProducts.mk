# Copyright 2023 Google LLC
PRODUCT_MAKEFILES := \
    sdv_core_cf:$(LOCAL_DIR)/sdv_core_cf/sdv_core_cf.mk \
    sdv_core_arm64:$(LOCAL_DIR)/sdv_core_arm64/sdv_core_arm64.mk \
    sdv_media_cf:$(LOCAL_DIR)/sdv_media_cf/sdv_media_cf.mk \
    sdv_media_arm64:$(LOCAL_DIR)/sdv_media_arm64/sdv_media_arm64.mk \
    sdv_ivi_cf:$(LOCAL_DIR)/sdv_ivi_cf/sdv_ivi_cf.mk \
    sdv_ivi_arm64:$(LOCAL_DIR)/sdv_ivi_arm64/sdv_ivi_arm64.mk

COMMON_LUNCH_CHOICES := \
    sdv_core_cf-userdebug \
    sdv_core_arm64-userdebug \
    sdv_media_cf-userdebug \
    sdv_media_arm64-userdebug \
    sdv_ivi_cf-userdebug \
    sdv_ivi_arm64-userdebug
