#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-curl'
      when "debian" then 'php5-curl'
      else 'php5-curl' # untested, so might be wrong
      end

package pkg