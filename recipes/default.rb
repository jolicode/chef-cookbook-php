#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
include_recipe "yum::epel" if platform_family?("rhel")
include_recipe "jolicode-php::php"