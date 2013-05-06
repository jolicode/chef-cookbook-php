#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: ext-zmq
#
pkgs = case node["platform_family"]
       when "rhel", "fedora" then [ 'php-devel', 'pkgconfig' ]
       when "debian" then [ 'php5-dev', 'pkg-config' ]
       else [ 'php5-dev', 'pkg-config' ] # untested, so might be wrong
       end

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
