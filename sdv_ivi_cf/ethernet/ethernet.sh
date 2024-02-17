#!/system/bin/sh

# Copyright 2023 Google LLC

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Default host environment expects IP of 192.68.98.3, so default to it.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

echo Setting IP address for eth1: $IP > /dev/kmsg

ifconfig eth1 $IP
ip route add 224.0.0.0/4 dev eth1
ifup eth1

# Temp workaround for PDK12- Add IP rule commands to allow applications in
# any network namespace to open sockets
ip rule add from all lookup main pref 0
ip route add default dev eth1
ip route flush cache
