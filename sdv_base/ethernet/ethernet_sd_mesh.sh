#!/system/bin/sh
# Copyright 2024 Google LLC

# Set the service discovery mesh IP rules in the sd_mesh_ns network namespace.
# The network namespace should be entered using a service modifier in the init .rc script.

# WARNING: the IP address of service discovery must match with the address in the vvmconfig.
# This may set the same IP address as the one used for the real network interface. That is
# perfectly okay, because sd_mesh has a different VLAN ID.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

ifconfig sd_mesh "$IP"

# This allow multicast
ip route add 224.0.0.0/4 dev sd_mesh

# This allow loopback support
ip link set dev lo up

ifup sd_mesh
