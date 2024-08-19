# Copyright 2024 Google LLC

LOCAL_PATH := $(call my-dir)

#######################################
# sdv_bugreport_folder_override
# TODO: b/360314949 - remove when b/353429422 (Migrate init.environ.rc to Soong) is fixed
#
# This module overwrites the /bugreport symlink set by init.environ.rc, so it must be installed
# after init.environ.rc.
# If you get an error like this:
#   ln: cannot create symbolic link from '/data/local/tmp/bugreports' to 'out/target/product/sdv_core_cf/root/bugreports': No such file or directory
# Or just an error without a message:
#   FAILED: out/target/product/sdv_core_cf/system/sdv_bugreport_folder_override
#   /bin/bash -c ...
# It means that init.environ.rc has not been called yet and there's an ordering problem.

include $(CLEAR_VARS)
LOCAL_MODULE := sdv_bugreport_folder_override
LOCAL_MODULE_CLASS := ETC
# What this target _technically_ does is creating a file at
# /system/etc/sdv_bugreport_folder_override which is unused.
# Our real payload is LOCAL_POST_INSTALL_CMD, which overrides the /bugreports symlink created in
# init.environ.rc.
LOCAL_SRC_FILES := unused_file_needed_for_sdv_bugreport_folder_override

# Make sure we create the original symlink first
LOCAL_REQUIRED_MODULES := init.environ.rc

# This command has two parts:
# 1. check that there already is a /bugreports symlink with test -L
# 2. make a new one, overriding the existing one
# The original symlink points to /data/user_de/0/com.android.shell/files/bugreports, but that
# folder hierarchy doesn't exist on SDV. We'll use /data/local/tmp/bugreports on SDV which is also
# an encryption-enabled folder.
# The check ensures that the symlink has been created already by init.environ.rc as a protection
# against reordering.
LOCAL_POST_INSTALL_CMD := test -L "${TARGET_ROOT_OUT}/bugreports"; \
  ln -sf /data/local/tmp/bugreports "${TARGET_ROOT_OUT}/bugreports"

include $(BUILD_PREBUILT)
