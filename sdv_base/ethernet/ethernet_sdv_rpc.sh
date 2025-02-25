#!/system/bin/sh
# Copyright 2025 Google LLC

# Fail on errors
set -e

# Set up the sdv_rpc VLAN.

# Note: because the main network interface is on a different VLAN, or, to be more precise, not
# even on a VLAN, using the same IP address as the one that main interface would also work.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.101.$VMID"

ifconfig sdv_rpc "$IP"

# This allows multicast
ip route add 224.0.0.0/4 dev sdv_rpc

# This allows loopback support
#ip link set dev lo up

ifconfig sdv_rpc up

# Setting up an arbitrary port range for automatic port selection for the services that uses
# sdv_rpc, which is only the SDV RPCAgent.
# -q instructs sysctl not to print the value to the standard output after writing it.
# TODO(hnandagopal): Figure out if this should be different from DT
sysctl -q -w net.ipv4.ip_local_port_range="4000 5999"

echo "sdv-ethernet-rpc-setup has started successfully"
