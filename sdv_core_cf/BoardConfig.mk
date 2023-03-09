# Copyright 2023 Google LLC
# SDV Core specific board config shall go into this file.
-include device/google/sdv/common_cf/BoardConfig.mk

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_cf/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_cf/sepolicy/system_ext/public
