#!/system/bin/sh

# Copyright 2023 Google LLC

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Default host environment expects IP of 192.68.98.3, so default to it.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

echo Setting IP address for eth1: $IP > /dev/kmsg
ifconfig eth1 $IP

