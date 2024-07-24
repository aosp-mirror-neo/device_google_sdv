#!/system/bin/sh

# Copyright 2024 Google LLC
# Set service discovery mesh ip rules in sd_mesh network namespace
# network namespace should be entered by modifier in service in init rc

VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

ifconfig sd_mesh "$IP"

## This allow multicast
ip route add 224.0.0.0/4 dev sd_mesh

## This allow loopback support
ip link set dev lo up

ifup sd_mesh
