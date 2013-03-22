#
# Author::  Benjamin Clay (<bclay@jolicode.com>)
# Cookbook Name:: php
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-xdebug),
    'default' => %w(php-xdebug)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-xdebug }
  },
  "default" => %w{ php5-xdebug }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template "#{node['jolicode-php']['real_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['jolicode-php']['config']['xdebug']
  })
end