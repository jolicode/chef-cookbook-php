define :php_fpm_pool, :cookbook => "jolicode-php", :user => "www-data", :group => "www-data" do
  
  if !params[:listen]
    params[:listen] = "/var/run/php5-fpm-#{params[:name]}.sock"
  end
      
  var = params
  
  config = {
    'name'   => params[:name],
    'user'   => params[:user],
    'group'  => params[:group],
    'listen' => params[:listen]
  }
  
  template "#{node['jolicode-php']['fpm_pool_dir']}/#{var[:name]}.conf" do
    source "fpm-pool.conf.erb"
    owner "root"
    group "root"
    cookbook  var[:cookbook]
    mode "0644"
    variables({
      :config => config
    })
  end
end