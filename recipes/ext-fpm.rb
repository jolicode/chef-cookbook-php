#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
if !node['jolicode-php']['dotdeb'] and platform?("debian")
  raise "In order to install php5-fpm on debian you need dotdeb"
end

pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-fpm),
    'default' => %w(php-fpm)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-fpm }
  },
  "default" => %w{ php5-fpm }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
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