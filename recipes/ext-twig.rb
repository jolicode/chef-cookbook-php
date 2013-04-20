#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkg = case node["platform_family"]
      when "rhel", "fedora" then 'php-devel'
      when "debian" then 'php5-dev'
      else 'php5-dev' # untested, so might be wrong
      end

package pkg

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