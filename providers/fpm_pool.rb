action :create do

  listen = if new_resource.listen.empty? then "/var/run/php5-fpm-#{new_resource.name}.sock"
           else new_resource.listen
           end

  template "#{node['jolicode-php']['fpm_pool_dir']}/#{new_resource.name}.conf" do
    source "fpm-pool.conf.erb"
    cookbook "jolicode-php"
    owner "root"
    group "root"
    mode "0644"
    variables({
      'config' => {
        'name'   => new_resource.name,
        'user'   => new_resource.user,
        'group'  => new_resource.group,
        'listen' => listen,
        'max_children' => new_resource.max_children,
        'start_servers' => new_resource.start_servers,
        'min_spare_servers' => new_resource.min_spare_servers,
        'max_spare_servers' => new_resource.max_spare_servers,
        'set_chdir' => new_resource.set_chdir,
        'set_chroot' => new_resource.set_chroot
      }
    })

    notifies :reload, "service[php-fpm]"
  end

  new_resource.updated_by_last_action(true)
end

action :remove do
  file "#{node['jolicode-php']['fpm_pool_dir']}/#{new_resource.name}.conf" do
    action :delete
    notifies :reload, "service[php-fpm]"
  end

  new_resource.updated_by_last_action(true)
end