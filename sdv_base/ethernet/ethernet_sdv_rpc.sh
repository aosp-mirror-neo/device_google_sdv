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

# Set up the sdv_rpc VLAN.

# Note: because the main network interface is on a different VLAN, or, to be more precise, not
# even on a VLAN, using the same IP address as the one that main interface would also work.
VMID=$(getprop ro.boot.virt.address 3)
if [ -n "$1" ]; then
  IP="$1"
else
  IP="192.168.101.$VMID"
fi

ifconfig sdv_rpc "$IP"

ifconfig sdv_rpc up

# Setting up an arbitrary port range for automatic port selection for the services that uses
# sdv_rpc, which is only the SDV RPCAgent.
# -q instructs sysctl not to print the value to the standard output after writing it.
# TODO(hnandagopal): Figure out if this should be different from DT
sysctl -q -w net.ipv4.ip_local_port_range="4000 5999"

setprop ro.sdv.oem.eth.rpc.up true

echo "ifconfig output:"
echo "$(ifconfig)"

log -t boot-timing -p i "sdv-ethernet-rpc-setup has started successfully"
