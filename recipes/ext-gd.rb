#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-gd'
      when "debian" then 'php5-gd'
      else 'php5-gd' # untested, so might be wrong
      end

package pkg