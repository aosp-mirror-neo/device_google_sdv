#!/system/bin/sh
# Copyright (C) 2026 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail on errors
set -e

# Set IP address for eth1 that corresponds to virtual ethernet in Cuttlefish.
# Must match the IP from the overlay's config.xml.
IP="192.168.98.118"

echo Setting IP address for eth1: $IP > /dev/kmsg

ip link set eth1 up
ip addr add "$IP/24" dev eth1
ip route add 224.0.0.0/4 dev eth1

echo "sdv-ethernet-setup has started successfully"
