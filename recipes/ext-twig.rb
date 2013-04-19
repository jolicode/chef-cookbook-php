#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-dev),
    'default' => %w(php-dev)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-dev }
  },
  "default" => %w{ php5-dev }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

jolicode_php_composer "create twig project" do
  action      :create_project
  cwd         node['jolicode-php']['twig']['source_dir']
  directory   "twig"
  package     "twig/twig"
  version     node['jolicode-php']['twig']['version']

  only_if { node['jolicode-php']['twig']['download'] }
end

bash "Compile twig extension" do
  cwd "#{node['jolicode-php']['twig']['source_dir']}/twig/ext/twig"
  code <<-EOH
  phpize
  ./configure
  make
  make install
  EOH
  not_if do
    File.exists?("#{node['jolicode-php']['ext_conf_dir']}/twig.ini")
  end
end

template "#{node['jolicode-php']['ext_conf_dir']}/twig.ini" do
  source "twig.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

directory "#{node['jolicode-php']['twig']['source_dir']}/twig" do
  action :delete
  recursive true

  only_if { node['jolicode-php']['twig']['download'] }
end