#Path attributes
default['jolicode-php']['dotdeb'] = false

case node["platform_family"]
when "rhel", "fedora"
  node.default['jolicode-php']['conf_dir']      = '/etc'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php.d'
  node.default['jolicode-php']['ext_dir'] = if node['kernel']['machine'] == 'x86_64' then '/usr/lib64/php/modules'
                                            else '/usr/lib/php/modules'
                                            end
when "debian"
  node.default['jolicode-php']['conf_dir']      = '/etc/php5/cli'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/conf.d'
  node.default['jolicode-php']['ext_dir'] = '/usr/lib/php5/20090626'

  if node['jolicode-php']['dotdeb']
    node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/mods-available'
  end
else
  node.default['jolicode-php']['conf_dir']      = '/etc/php5/cli'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/conf.d'
  node.default['jolicode-php']['ext_dir'] = '/usr/lib/php5/20090626'
end