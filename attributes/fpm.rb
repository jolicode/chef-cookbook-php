include_attribute "jolicode-php"

case node["platform_family"]
when "rhel", "fedora"
  default['jolicode-php']['fpm_dir']       = "/etc/php-fpm.d"
  default['jolicode-php']['fpm_pool_dir']  = "/etc/php-fpm.d"
when "debian"
  default['jolicode-php']['fpm_dir']       = "/etc/php5/fpm"
  default['jolicode-php']['fpm_pool_dir']  = "/etc/php5/fpm/pool.d"
else
  default['jolicode-php']['fpm_dir']       = "/etc/php5/fpm"
  default['jolicode-php']['fpm_pool_dir']  = "/etc/php5/fpm/pool.d"
end

default['jolicode-php']['fpm']['enable_default_pool'] = true

#Php ini attributes
default['jolicode-php']['fpm']['config']['pool_dir'] = node['jolicode-php']['fpm_pool_dir']
default['jolicode-php']['fpm']['config']['error_log']               = "/var/log/php5-fpm.log"
default['jolicode-php']['fpm']['config']['syslog_facility']         = "daemon"
default['jolicode-php']['fpm']['config']['syslog_ident']            = "php-fpm"
default['jolicode-php']['fpm']['config']['log_level']               = "notice"
default['jolicode-php']['fpm']['php-config']['date.timezone']       = "Europe/Paris"
default['jolicode-php']['fpm']['php-config']['max_execution_time']  = "-1"
default['jolicode-php']['fpm']['php-config']['memory_limit']        = "-1"
default['jolicode-php']['fpm']['php-config']['html_errors']         = "Off"
default['jolicode-php']['fpm']['php-config']['display_errors']      = "Off"
default['jolicode-php']['fpm']['php-config']['upload_max_filesize'] = "2M"
default['jolicode-php']['fpm']['php-config']['post_max_size']       = "8M"
default['jolicode-php']['fpm']['php-config']['error_log']           = ""
default['jolicode-php']['fpm']['php-config']['expose_php']           = "Off"