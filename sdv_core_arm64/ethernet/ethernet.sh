#!/system/bin/sh

# Copyright 2023 Google LLC

# Setting two ip addresses to the eth0 as current hypervisor setup is forwarding
# traffic to different IP addresses. To avoid a new QNX image, we configure
# eth0 to accept data to both addresses, but, longer-term, this will get
# consolidated to a single entry
ifconfig eth0 192.168.101.3
ifconfig eth0:0 192.168.101.4
ip r add default via 192.168.101.1