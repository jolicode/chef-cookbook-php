#Path attributes
default['jolicode-php']['dotdeb'] = false

case node["platform_family"]
when "redhat", "centos", "fedora", "scientific"
  node.default['jolicode-php']['conf_dir']      = '/etc'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php.d'
when "ubuntu", "debian"
  node.default['jolicode-php']['conf_dir']      = '/etc/php5/cli'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/conf.d'

  if node['jolicode-php']['dotdeb']
    node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/mods-available'
  end
else
  node.default['jolicode-php']['conf_dir']      = '/etc/php5/cli'
  node.default['jolicode-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  node.default['jolicode-php']['real_conf_dir'] = '/etc/php5/conf.d'
end