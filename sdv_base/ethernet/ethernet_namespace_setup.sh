#!/system/bin/sh
# Copyright 2024 Google LLC

# Fail on errors
set -e

# Setup the network namespaces and VLANs for the service discovery and data tunnel agents on top of
# the network interface passed as the argument
NETWORK_INTERFACE="$1"

#########################################################################################
# create a VLAN for service discovery agent and move it to a sd_mesh_ns network namespace
#########################################################################################

ip link add link "${NETWORK_INTERFACE}" name sd_mesh type vlan id 1

# Create a separate sd_mesh_ns namespace solely for the use of the service discovery agent, and
# move the sd_mesh network interface to that network namespace, so only service discovery can
# access that VLAN interface for security isolation.
# Once the sd_mesh network interface is moved, we will no longer be able to see it from here
# without entering sd_mesh_ns network namespace.
ip netns add sd_mesh_ns
ip link set sd_mesh netns sd_mesh_ns

# We cannot use "ip netns exec" here to configure IP rules in the sd_mesh_ns network namespace,
# since "ip netns exec" will always need to remount sysfs when entering the namespace, and there is
# a neverallow domain (filesystem (mount remount relabelfrom relabelto))).
#
# Instead, we configure the IP rules in a separate script that has an enter_namespace init .rc
# service modifier, so init remounts sysfs and enter the network namespace for us. See
# ethernet_sd_mesh.sh.

######################################################################################
# create a VLAN for the data tunnel agent and move it to a sdv_dt_ns network namespace
######################################################################################

ip link add link "${NETWORK_INTERFACE}" name sdv_dt type vlan id 2

# Create a separate sdv_dt_ns namespace solely for the use of the data tunnel agent, and move the
# sdv_dt network  interface to that network namespace, so only data tunnel can access that VLAN
# interface for security isolation.
# Once the sdv_dt network interface is moved, we will no longer be able to see it from here without
# entering sdv_dt_ns network namespace.
ip netns add sdv_dt_ns
ip link set sdv_dt netns sdv_dt_ns

######################################################################################
# create a VLAN for the RPC agent and keep it in the root namespace
######################################################################################

ip link add link "${NETWORK_INTERFACE}" name sdv_rpc type vlan id 3

echo "sdv-ethernet-namespace-setup has started successfully"
