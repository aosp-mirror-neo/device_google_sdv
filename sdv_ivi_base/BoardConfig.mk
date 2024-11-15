# Copyright 2024 Google LLC

# Common configurations between all IVI targets

# Have SD Agent on IVI read ACL file mappings from directories
$(call soong_config_set,sdv_authz,acl_provider_type,ivi_acl_provider)
