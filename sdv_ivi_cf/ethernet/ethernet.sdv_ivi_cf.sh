#!/system/bin/sh
# Copyright 2023 Google LLC

# Fail on errors
set -e

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Must match the IP from the overlay's config.xml.
IP="192.168.98.118"

echo Setting IP address for eth1: $IP > /dev/kmsg

ifconfig eth1 $IP
ip route add 224.0.0.0/4 dev eth1
ifconfig eth1 up

echo "sdv-ethernet-setup has started successfully"
