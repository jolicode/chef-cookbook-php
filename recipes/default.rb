#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
include_recipe "yum::epel" if platform_family?("rhel")
include_recipe "jolicode-php::php"

# We'll need this to build extensions
node.set['build_essential']['compiletime'] = true
include_recipe "build-essential::default"