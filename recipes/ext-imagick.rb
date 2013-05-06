#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-pecl-imagick'
      when "debian" then 'php5-imagick'
      else 'php5-imagick' # untested, so might be wrong
      end

package pkg