# Description

Install and configure php, instead of the offcial one, this cookbook does not depend on apache and will not use or install pear.

# Platform

This cookbook intend to work on these platform : Debian/Ubuntu (with or without Dotdeb), Centos/Redhat/Scientific/Fedora.

# Requirements

There are no cookbooks dependency 

# Recipes

*  php
*  composer
*  ext-apc
*  ext-curl
*  ext-dom
*  ext-fpm
*  ext-gd
*  ext-imagick
*  ext-intl
*  ext-mbstring
*  ext-mcrypt
*  ext-mysql
*  ext-pdo
*  ext-posix
*  ext-twig
*  ext-xdebug
*  ext-zmq

# Attributes

Name | Description
--- | ---
['jolicode-php']['dotdeb'] | Set to true if you use dotdeb
['jolicode-php']['conf_dir'] | Directory where php.ini file is on system
['jolicode-php']['ext_conf_dir'] | Extension directory used in php configuration
['jolicode-php']['real_conf_dir'] | Real extension directory for extension configuration file (useful with dotdeb where config file in 'ext_conf_dir' are link to 'real_conf_dir' files)
['jolicode-php']['config'] | All attributes for php.ini configuration files

# Resources

## Composer

Composer ressource declare 3 actions : `install`, `update` and `create_project`

### Options

* cwd : Where to run composer in
* user: Which user run the composer command
* group : Which group run the composer command
* package : For use with create_project to specifiy package to install
* options : To add extra values in composer command
* version : For use with create_project to set wich version of package to install
* directory : For use with create_project to set path of new package installed

### Examples

```ruby
jolicode_php_composer "Install my dependencies" do
  cwd     "/path/to/my/project"
  user    "www-data"
  options "--dev"
  action  :install
end
```

This will run `composer install --dev` in `/path/to/my/project` directory


## Php-fpm


### Actions

* remove

### Attributes

* user : The use to run the workers under (defaults to "www-data")
* group : The group to run the workers under (defaults to "www-data")
* listen : The IP:port binding or the socket to set up for this pool (defaults to "/var/run/php5-fpm-{application_name}.sock")
* max_children (defaults to 5)
* start_servers (defaults to 2)
* min_spare_servers (defaults to 1)
* max_spare_servers (defaults to 3)

### Examples

```ruby
jolicode_php_fpm_pool "my_application"
  action :create
end

```

The above will create a new php-fpm pool configuration file under `/etc/php5/fpm/pool.d/my_application.ini`,
and sets it up to listen on the socket under `/var/run/php5-fpm-my_application.sock`.


# Dotdeb

All recipes are compatible with dotdeb repository. You need to set jolicode-php['dotdeb'] attribute to true when using dotdeb.