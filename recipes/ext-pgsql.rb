#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: jolicode-php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-pgsql'
      when "debian" then 'php5-pgsql'
      else 'php5-pgsql' # untested, so might be wrong
      end

package pkg