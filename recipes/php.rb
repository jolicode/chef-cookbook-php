#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkgs = case node["platform_family"]
       when "rhel", "fedora" then [ 'php-cli', 'php-common' ]
       when "debian" then [ 'php5-cli', 'php5-common' ]
       else [ 'php5-cli', 'php5-common' ]
       end

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