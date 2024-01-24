#!/system/bin/sh

# Copyright 2023 Google LLC

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Default host environment expects IP of 192.68.98.3, so default to it.
VMID=$(getprop ro.boot.virt.address 3)
IP="192.168.98.$VMID"

echo Setting IP address for eth1: $IP > /dev/kmsg

# create a vlan for service discovery mesh
ip link add link eth1 name sd_mesh type vlan id 1

# move the service discovery mesh into a difference namespace solely for service
# discovery use, so only service discovery can access that vlan interface
# for security isolation
# Currently we use same ip address, it is perfectly okay to have same ip
# address, since it is in different vlan interface
ip netns add sd_mesh
ip link set sd_mesh netns sd_mesh
ip netns exec sd_mesh ifconfig sd_mesh $IP
ip netns exec sd_mesh ip route add 224.0.0.0/4 dev sd_mesh
ip netns exec sd_mesh ip link set dev lo up
ip netns exec ifup sd_mesh

# TODO create another vlan for rpcagent, move rpcagent and eth1 to a different
# network namespace once all agent goes though rpcagent
ifconfig eth1 $IP
ip route add 224.0.0.0/4 dev eth1
ifup eth1
