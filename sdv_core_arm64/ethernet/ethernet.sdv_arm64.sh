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

# Default host environment expects IP of 192.68.98.3/4, so default to them.
VMID="$(getprop ro.boot.virt.address 3)"
FIRST_IP="$(getprop ro.boot.virt.static_ip1 "192.168.98.$VMID")"
DEFAULT_GW_IP="$(getprop ro.boot.virt.static_gateway_ip "192.168.98.1")"

# Only one process of `ip` is spawned which executes all the commands
# `route add 224.0.0.0/4 dev eth0` is to enable multicast on eth0 interface (required for SOMEIP SD)
echo "link set eth0 up
addr add '$FIRST_IP/24' dev eth0
r add default via '$DEFAULT_GW_IP'
route add 224.0.0.0/4 dev eth0" | ip -b -

setprop ro.sdv.oem.eth.setup.ready true

log -t boot-timing -p i "sdv-ethernet-setup has started successfully"
