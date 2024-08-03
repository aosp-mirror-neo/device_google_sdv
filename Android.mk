# Copyright 2023 Google LLC

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/sdv-binary-pdk.mk
include $(LOCAL_PATH)/sdv_core_base/sdv_bugreport_folder_override/Android.mk
