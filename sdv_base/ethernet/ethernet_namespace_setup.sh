#!/system/bin/sh
# Copyright 2024 Google LLC

# Setup network namespace and VLAN for sd_mesh on top of the network interface passed as
# the argument
NETWORK_INTERFACE="$1"

########################################################################################
# create a VLAN for service discovery mesh and move it to a sd_mesh_ns network namespace
########################################################################################

ip link add link "${NETWORK_INTERFACE}" name sd_mesh type vlan id 1

# Move the service discovery mesh into a difference namespace solely for service discovery use, so
# only service discovery can access that VLAN interface for security isolation.
ip netns add sd_mesh_ns

# Move network interface sd_mesh to network namespace sd_mesh_ns.
# Once it's moved, we will no longer be able to see the sd_mesh network interface here without
# entering sd_mesh_ns network namespace.
ip link set sd_mesh netns sd_mesh_ns

# We cannot use "ip netns exec" here to configure IP rules in the sd_mesh_ns network namespace,
# since "ip netns exec" will always need to remount sysfs when entering the namespace, and there is
# a neverallow domain (filesystem (mount remount relabelfrom relabelto))).
#
# Instead, we configure the IP rules in a separate script that has an enter_namespace init .rc
# service modifier, so init remounts sysfs and enter the network namespace for us. See
# ethernet_sd_mesh.sh.
