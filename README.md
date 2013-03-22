Description
===========

This cookbook intend to install php and php only this will not install php for apache, see the php-apache for that.
Some extensions are availables :

*ext-apc
*ext-curl
*ext-dom
*ext-fpm
*ext-gd
*ext-imagick
*ext-intl
*ext-mbstring
*ext-mcrypt
*ext-mysql
*ext-pdo
*ext-posix
*ext-twig
*ext-xdebug
*ext-zmq

This cookbook also provide a recipe to install composer
All recipes are intend to work under devian/ubuntu/rhel/centos/fedora/scientific and is compatible with dotdeb package on debian
Feel free to contributes

Requirements
============

For extension fpm on debian dotdeb is mandatory

Attributes
==========

conf_dir and ext_conf_dir are for system don't change them
All values under config can be changed to set a correct php.ini files (this will only change client configuration)

Dotdeb
======

All recipes are compatible with dotdeb repository. You need to set jolicode-php['dotdeb'] attribute to true when using dotdeb. 