#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
if !node['jolicode-php']['dotdeb'] and platform?("debian")
  raise "In order to install php5-fpm on debian you need dotdeb"
end

fpm_package_name = case node["platform_family"]
                   when "rhel", "fedora" then 'php-fpm'
                   when "debian" then 'php5-fpm'
                   else 'php5-fpm' # untested, so might be wrong
                   end

package fpm_package_name

# This way we can refer to this service irrespective of the platform
service "php-fpm" do
  service_name fpm_package_name
  action [:enable, :start]
end

template "#{node['jolicode-php']['fpm_dir']}/php-fpm.conf" do
  source "php5-fpm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    'config' => node['jolicode-php']['fpm']['config']
  })
end

if node['jolicode-php']['fpm_dir'] != node['jolicode-php']['conf_dir']
  template "#{node['jolicode-php']['fpm_dir']}/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
      :config => node['jolicode-php']['fpm']['php-config']
    })
  end
else
  Chef::Log.warn "This platform only supports a single php.ini file - can't create a separate one for php-fpm"
end

# default pool
if node['jolicode-php']['fpm']['enable_default_pool']

  group node['jolicode-php']['fpm']['default_group'] do
    gid node['jolicode-php']['fpm']['default_gid']
  end

  user node['jolicode-php']['fpm']['default_user'] do
    uid node['jolicode-php']['fpm']['default_uid']
    gid node['jolicode-php']['fpm']['default_gid']
  end

  jolicode_php_fpm_pool "www" do
    user node['jolicode-php']['fpm']['default_user']
    group node['jolicode-php']['fpm']['default_group']
    action :create
  end
end