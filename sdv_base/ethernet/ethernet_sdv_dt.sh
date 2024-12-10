#!/system/bin/sh
# Copyright 2024 Google LLC

# Set up the data tunnel IP rules in the sdv_dt_ns network namespace.
# The network namespace should be entered using a service modifier in the init .rc script.

# This may set the same IP address as the one used for the main network interface or for other VLAN
# interfaces. That is perfectly okay, because sdv_dt has a different VLAN ID.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

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
