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

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Default host environment expects IP of 192.68.98.3, so default to it.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

echo Setting IP address for eth1: $IP > /dev/kmsg

ip addr add "$IP/24" dev eth1
ip route add 224.0.0.0/4 dev eth1
ip link set eth1 up

# On non-IVI targets, eth1 is only used by SDV RPC, Service Discovery and Data tunnel have their
# own network interfaces.
# On IVI targets, eth1 is used by SDV RPC and it's also the default network interface for whole
# Android. Service Discovery and Data tunnel have their own network interfaces.

log -t boot-timing -p i "sdv-ethernet-setup has started successfully"
