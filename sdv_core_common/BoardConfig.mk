# Copyright 2023 Google LLC

# Defining the SEPolicies of the SDV packages located on the system_ext partition by amending the
# private and public policies of the partition. See system/sepolicy/README.md for more details.
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/google/sdv/sdv_core_common/sepolicy/system_ext/public
