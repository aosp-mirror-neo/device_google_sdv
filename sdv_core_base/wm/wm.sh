#!/system/bin/sh
# Copyright 2025 Google LLC
#
# No operational (NoOp) implementation of WM (Window Manager).
# Enables the CTS SDV test plan testing on SDV Core images.
# Mitigates the ANDROID_SYSTEM_SETTING_DISMISS_KEYGUARD_ERROR:
#   "/system/bin/sh: wm: inaccessible or not found"
echo "Noop WM: exit with success (0 code)."
exit 0
