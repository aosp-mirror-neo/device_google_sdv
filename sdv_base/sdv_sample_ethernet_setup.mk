# Copyright 2024 Google LLC

# The rules that install the SDV sample network configuration script for all lunch targets that
# need to communicate with the SDV system using SDV communications stack

PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_sd_mesh.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_sd_mesh.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_sdv_dt.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_sdv_dt.sh
PRODUCT_COPY_FILES += device/google/sdv/sdv_base/ethernet/ethernet_namespace_setup.sh:$(TARGET_COPY_OUT_PRODUCT)/bin/ethernet/ethernet_namespace_setup.sh
