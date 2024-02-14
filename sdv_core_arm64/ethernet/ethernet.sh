#!/system/bin/sh

# Copyright 2023 Google LLC

# Setting two ip addresses to the eth0 as current hypervisor setup is forwarding
# traffic to different IP addresses. To avoid a new QNX image, we configure
# eth0 to accept data to both addresses, but, longer-term, this will get
# consolidated to a single entry
# Default host environment expects IP of 192.68.101.3/4, so default to them.
VMID="$(getprop ro.boot.virt.address 3)"
FIRST_IP="$(getprop ro.boot.virt.static_ip1 "192.168.101.$VMID")"
SECOND_IP="$(getprop ro.boot.virt.static_ip2 "192.168.101.$((VMID+1))")"
DEFAULT_GW_IP="$(getprop ro.boot.virt.static_gateway_ip "192.168.101.1")"

ifconfig eth0 "$FIRST_IP"
ifconfig eth0:0 "$SECOND_IP"
ip r add default via "$DEFAULT_GW_IP"

# create a vlan for service discovery mesh
ip link add link eth0 name sd_mesh type vlan id 1

# move the service discovery mesh into a difference namespace solely for service
# discovery use, so only service discovery can access that vlan interface
# for security isolation
# Currently we use same ip address, it is perfectly okay to have same ip
# address, since it is in different vlan interface
ip netns add sd_mesh
ip link set sd_mesh netns sd_mesh
ip netns exec sd_mesh ifconfig sd_mesh $FIRST_IP
ip netns exec sd_mesh ip route add 224.0.0.0/4 dev sd_mesh
ip netns exec sd_mesh ip link set dev lo up
ip netns exec ifup sd_mesh

# Enable multicast on eth0 interface (required for SOME/IP SD)
ip route add 224.0.0.0/4 dev eth0
ifup eth0
