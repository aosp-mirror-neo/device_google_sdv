# Copyright 2024 Google LLC
#
# Software-Defined Vehicle (SDV) is a headless vehicle Android OS.
# The 'Core' device/product/model defines the base SDV functionality to be reused/inherited by other
# functional SDV profiles (cluster, telemetry, telematics, etc) and by the OEMs.

PRODUCT_COPY_FILES += device/google/sdv/sdv_core_base/ethernet/ethernet_sd_mesh.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet_sd_mesh.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_core_base/ethernet/ethernet_namespace_setup.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/ethernet/ethernet_namespace_setup.sh
