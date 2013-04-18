#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
if !node['jolicode-php']['dotdeb'] and platform?("debian")
  raise "In order to install php5-fpm on debian you need dotdeb"
end

fpm_package_name = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => "php53-fpm",
    'default' => "php-fpm"
  },
  [ "debian", "ubuntu" ] => {
    "default" => "php5-fpm"
  },
  "default" => "php5-fpm"
)

package fpm_package_name do
  action :install
end

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
    :config => {
      'pool_dir' => node['jolicode-php']['fpm_pool_dir']
    }
  })
end

template "#{node['jolicode-php']['fpm_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['jolicode-php']['fpm']['php-config']
  })
end

# default pool
php_fpm_pool "www" do
  action :run
end