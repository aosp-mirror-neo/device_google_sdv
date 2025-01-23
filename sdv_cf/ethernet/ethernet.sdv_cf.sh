#!/system/bin/sh
# Copyright 2023 Google LLC

# Fail on errors
set -e

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Default host environment expects IP of 192.68.98.3, so default to it.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

echo Setting IP address for eth1: $IP > /dev/kmsg

ifconfig eth1 "$IP"
ip route add 224.0.0.0/4 dev eth1
ifconfig eth1 up

# On non-IVI targets, eth1 is only used by SDV RPC, Service Discovery and Data tunnel have their
# own network interfaces.
# On IVI targets, eth1 is used by SDV RPC and it's also the default network interface for whole
# Android. Service Discovery and Data tunnel have their own network interfaces.

echo "sdv-ethernet-setup has started successfully"
