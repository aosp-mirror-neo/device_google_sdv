# Copyright 2024 Google LLC

$(call add_soong_config_namespace,SDV)
$(call soong_config_set,SDV,SDV_PREBUILT,$(if $(SDV_PREBUILT),true,false))
