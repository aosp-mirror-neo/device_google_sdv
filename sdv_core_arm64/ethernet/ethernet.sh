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

# Enable multicast on eth0 interface (required for SOME/IP SD)
ip route add 224.0.0.0/4 dev eth0
