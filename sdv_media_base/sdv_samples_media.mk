# Copyright 2023-2024 Google LLC
#
# All the SDV Media samples.
#
# These are not included in sdv_media_base.mk. Targets need to include them explicitly.

# Audio samples
SDV_MEDIA_SAMPLES_PACKAGES = \
    tinyplay2 \
    tinymix2 \
    tinycap2 \

# Sample application that renders to multiple displays.
SDV_MEDIA_SAMPLES_PACKAGES += \
    sdv_multi_display_sample_rust \
    sdv_screencap \

SDV_MEDIA_HOST_SAMPLES_PACKAGES =

PRODUCT_PACKAGES += $(SDV_MEDIA_SAMPLES_PACKAGES)

PRODUCT_HOST_PACKAGES += $(SDV_MEDIA_HOST_SAMPLES_PACKAGES)
