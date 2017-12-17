#
# Cookbook:: node_subnet
# Recipe:: node_subnet_module
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'node_subnet::default'
ohai_plugin 'node_subnet_module'
