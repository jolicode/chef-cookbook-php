#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-mcrypt'
      when "debian" then 'php5-mcrypt'
      else 'php5-mcrypt' # untested, so might be wrong
      end

package pkg