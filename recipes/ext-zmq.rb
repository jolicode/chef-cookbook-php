#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: ext-zmq
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-dev pkg-config),
    'default' => %w(php-dev pkg-config)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-dev pkg-config }
  },
  "default" => %w{ php5-dev pkg-config }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

archive_url  = "https://github.com/mkoppanen/php-zmq/archive/#{node['jolicode-php']['zmq']['version']}.tar.gz"
archive_dir  = "php-zmq-#{node['jolicode-php']['zmq']['version']}"
archive_file = File.join(Chef::Config[:file_cache_path], "/", "php-zmq-#{node['jolicode-php']['zmq']['version']}.tar.gz")

remote_file archive_file do
  source archive_url
end

bash "Compile zmq extension" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf #{archive_file}
    cd #{archive_dir}
    phpize
    ./configure --with-zmq=#{node['jolicode-php']['zmq']['lib']}
    make
    make install
  EOH
  not_if do
    File.exists?("#{node['jolicode-php']['ext_conf_dir']}/zmq.ini")
  end
end

template "#{node['jolicode-php']['ext_conf_dir']}/zmq.ini" do
  source "zmq.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end
