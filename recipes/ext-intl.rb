#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-intl'
      when "debian" then 'php5-intl'
      else 'php5-intl' # untested, so might be wrong
      end

package pkg