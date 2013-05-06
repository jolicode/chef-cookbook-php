#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#

# Installs PHP-FPM and creates default pool
include_recipe "jolicode-php::ext-fpm"


# Create another appolication pool

group "test_group" do
  gid 3500
end

user "test_user" do
  uid 3500
  gid 3500
end

jolicode_php_fpm_pool "my_app" do
  user "test_user"
  group "test_group"
  process_manager 'static'
  max_children 5
  status_path "/status"
  notifies :restart, "service[php-fpm]"
end


# And an Nginx vhost to proxy the status page
node.set['nginx']['default_site_enabled'] = false
include_recipe "nginx::default"

template "/etc/nginx/sites-available/my_app_status" do
  source "php-fpm-status.conf.erb"
  owner "root"
  mode "0644"

  variables({
    'app_name' => 'my_app',
    'status_port' => 8095
  })

  action :create
  notifies :reload, "service[nginx]"
end

nginx_site "my_app_status" do
  enable true
end