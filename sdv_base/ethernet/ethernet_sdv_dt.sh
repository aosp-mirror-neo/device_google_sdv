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

# Set up the data tunnel IP rules in the sdv_dt_ns network namespace.
# The network namespace should be entered using a service modifier in the init .rc script.

# Note: because the main network interface is on a different VLAN, or, to be more precise, not
# even on a VLAN, using the same IP address as the one that main interface would also work.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.100.$VMID"

ifconfig sdv_dt "$IP"

# This allows multicast
ip route add 224.0.0.0/4 dev sdv_dt

# This allows loopback support
ip link set dev lo up

ifconfig sdv_dt up

# Setting up an arbitrary port range for automatic port selection for the services that uses
# sdv_dt, which is only the SDV data tunnel agent.
# -q instructs sysctl not to print the value to the standard output after writing it.
sysctl -q -w net.ipv4.ip_local_port_range="6000 7999"

setprop ro.sdv.oem.eth.dt.up true

log -t boot-timing -p i "sdv-ethernet-dt-setup has started successfully"
