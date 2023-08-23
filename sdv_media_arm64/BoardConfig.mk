# Copyright 2023 Google LLC
# SDV Media specific board config shall go into this file.

# Note: include order matters, sdv_media may need to override some of the
# settings defined in core.
include device/google/sdv/sdv_core_arm64/BoardConfig.mk
include device/google/sdv/sdv_media_common/BoardConfig.mk
