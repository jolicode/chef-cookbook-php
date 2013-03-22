#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(pcre-devel php53-devel),
    'default' => %w(php-pecl-apc)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php-apc }
  },
  "default" => %w{ php-apc }
)

if node['jolicode-php']['dotdeb']
  pkgs = %w{ php5-apc }
end

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

if platform?("centos", "redhat", "scientific", "fedora") and node[:platform_version].to_f < 6.0 and !File.exists?("#{node['jolicode-php']['ext_conf_dir']}/apc.ini")
  bash "Compile apc package" do
    cwd "/tmp"
    code <<-EOH
    wget http://pecl.php.net/get/APC-#{node['jolicode-php']['apc']['version']}.tgz
    tar xvzf APC-#{node['jolicode-php']['apc']['version']}.tgz 
    cd APC-#{node['jolicode-php']['apc']['version']}
    phpize
    ./configure
    make
    make install
    cd ..
    rm -rf APC-#{node['jolicode-php']['apc']['version']}
    rm APC-#{node['jolicode-php']['apc']['version']}.tgz
    EOH
  end
end

template "#{node['jolicode-php']['real_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['jolicode-php']['apc']['config']
  })
end