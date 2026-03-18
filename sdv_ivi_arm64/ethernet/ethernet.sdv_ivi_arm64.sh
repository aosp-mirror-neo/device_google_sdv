#!/system/bin/sh
# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail on errors
set -e

# Set the static IPs 192.68.98.118/119, but Connectivity Manager only
# reconfigures the network to use the first IP in the overlay configuration.
VMID="$(getprop ro.boot.virt.address 3)"
FIRST_IP="$(getprop ro.boot.virt.static_ip1 "192.168.98.118")"
DEFAULT_GW_IP="$(getprop ro.boot.virt.static_gateway_ip "192.168.98.1")"

# Only one process of `ip` is spawned which executes all the commands
# `route add 224.0.0.0/4 dev wlan0` is to enable multicast on wlan0 interface (required for SOMEIP SD)
echo "link set wlan0 up
addr add '$FIRST_IP/24' dev wlan0
route add 224.0.0.0/4 dev wlan0" | ip -b -

# Started failing on IVI arm64 recently, does not seem to be mandatory.
echo "skipping on IVI arm64: ip r add default via '$DEFAULT_GW_IP'"

log -t boot-timing -p i "sdv-ethernet-setup has started successfully"
