#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = if node['jolicode-php']['dotdeb'] then 'php5-apc'
      else
        case node["platform_family"]
        when "rhel", "fedora" then 'php-pecl-apc'
        when "debian" then 'php-apc'
        else 'php-apc' # untested, so might be wrong
        end
      end

package pkg

template "#{node['jolicode-php']['real_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['jolicode-php']['apc']['config']
  })
end