#!/system/bin/sh

# Copyright 2024 Google LLC
# Setup network namespace and vlan for rpcagent and sd_mesh
NETWORK_INTERFACE="$1"

################################################################################
# create a vlan for service discovery mesh and move to network namespace sd_mesh
################################################################################
ip link add link "${NETWORK_INTERFACE}" name sd_mesh type vlan id 1

# Move the service discovery mesh into a difference namespace solely for service
# discovery use, so only service discovery can access that vlan interface
# for security isolation
# Currently we use same ip address, it is perfectly okay to have same ip
# address, since it is in different vlan interface
ip netns add sd_mesh

# Move network interface sd_mesh to network namespace sd_mesh
# Once moved, we no longer be able to see the network interface sd_mesh here
# without entering sd_mesh network namespace
ip link set sd_mesh netns sd_mesh

# We cannot use "ip netns exec" here to config ip rules for sd_mesh network namespace,
# since "ip netns exec" will always need to remount sysfs when entering the
# namespace, there is a neverallow domain (filesystem (mount remount relabelfrom relabelto)))
#
# We would do it in a separated script and by using enter_namespace in
# init rc service modifiers, which init would remount sysfs and enter the network namespace for us
#
# Instead of using "ip netns exec" here, see ethernet_rpcagent.sh and ethernet_sd_mesh.sh files

###################################################################
# create a vlan for rpcagent and move to network namespace rpcagent
###################################################################
ip link add link "${NETWORK_INTERFACE}" name rpcagent type vlan id 2
ip netns add rpcagent
ip link set rpcagent netns rpcagent
