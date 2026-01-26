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

# Set the service discovery mesh IP rules in the sd_mesh_ns network namespace.
# The network namespace should be entered using a service modifier in the init .rc script.

# Note: because the main network interface is on a different VLAN, or, to be more precise, not
# even on a VLAN, using the same IP address as the one that main interface would also work.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.99.$VMID"

ifconfig sd_mesh "$IP"

# This allows multicast
ip route add 224.0.0.0/4 dev sd_mesh

# This allows loopback support
ip link set dev lo up

ifconfig sd_mesh up

setprop ro.sdv.oem.eth.sd_mesh.up true

log -t boot-timing -p i "sdv-ethernet-sd-mesh-setup has started successfully"
