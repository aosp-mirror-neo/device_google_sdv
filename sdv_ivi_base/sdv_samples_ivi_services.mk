# Copyright 2024 Google LLC
#
# All the packages required to be installed into the SDV_IVI target are placed
# here.
#

# Samples in core_services/ specific to SDV_IVI target
SDV_IVI_SERVICES_SAMPLES_PACKAGES = \
    native_sdv_gateway_test_app \
    sdv_vhal_proxy_publisher \
    sdv_vhal_proxy_subscriber \
    ivi_acl_provider_vendor_acl_textproto \
    ivi_acl_provider_product_acl_textproto \
    ivi_acl_provider_system_acl_textproto \
    ivi_acl_provider_system_ext_acl_textproto \
    rochambeau_player_rs \
    rochambeau_judge_rs \


SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_IVI_SERVICES_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_IVI_SERVICES_HOST_SAMPLES_PACKAGES)

# Include the packagemanagerproxyd test client
include packages/services/Car/cpp/packagemanagerproxy/testclient/products/packagemanagerproxy.mk
