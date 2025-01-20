#!/system/bin/sh
# Copyright 2024 Google LLC

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

echo "sdv-ethernet-sd-mesh-setup has started successfully"
