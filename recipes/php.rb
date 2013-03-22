#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-cli php53-common),
    'default' => %w(php-cli php-common)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-cli php5-common }
  },
  "default" => %w{ php5-cli php5-common }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

template node.default['jolicode-php']['conf_dir'] + "/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['jolicode-php']['config']
  })
end