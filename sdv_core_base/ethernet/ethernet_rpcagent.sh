#!/system/bin/sh
# Copyright 2024 Google LLC

# Set rpcagent ip rules in rpcagent network namespace
# network namespace should be entered by modifier in service in init rc

VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

ifconfig rpcagent "$IP"

## This allow loopback support
ip link set dev lo up

ifup rpcagent
