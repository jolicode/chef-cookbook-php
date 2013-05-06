#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-mysql'
      when "debian" then 'php5-mysql'
      else 'php5-mysql' # untested, so might be wrong
      end

package pkg