#!/system/bin/sh
# Copyright 2024 Google LLC

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

echo "sdv-ethernet-dt-setup has started successfully"
