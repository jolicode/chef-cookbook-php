name             "jolicode-php"
maintainer       "JoliCode"
maintainer_email "jwurtz@jolicode.com"
license          "Apache 2.0"
description      "Installs/Configures Jolicode Chef Cookbook for PHP"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"
recipe           "jolicode-php", "Alias for jolicode-php::php"
recipe           "jolicode-php::php", "Php client (no web server)"
recipe           "jolicode-php::composer", "Composer package manager"
recipe           "jolicode-php::ext-apc", "APC extension"
recipe           "jolicode-php::ext-curl", "PHP Curl extension"
recipe           "jolicode-php::ext-dom", "PHP DOM extension"
recipe           "jolicode-php::ext-fpm", "PHP Fpm, for debian squeeze you need dotdeb"
recipe           "jolicode-php::ext-gd", "PHP Gd extension"
recipe           "jolicode-php::ext-imagick", "PHP Imagick extension"
recipe           "jolicode-php::ext-intl", "PHP Intl extension"
recipe           "jolicode-php::ext-mbstring", "PHP mbstring extension"
recipe           "jolicode-php::ext-mcrypt", "PHP Mcrypt extension"
recipe           "jolicode-php::ext-mysql", "PHP MySql extension"
recipe           "jolicode-php::ext-pdo", "PHP PDO extension"
recipe           "jolicode-php::ext-posix", "PHP Posix extension"
recipe           "jolicode-php::ext-twig", "PHP Twig extension"
recipe           "jolicode-php::ext-xdebug", "PHP XDebug extension"
recipe           "jolicode-php::ext-zmq", "PHP Zmq extension"

%w{ debian ubuntu centos fedora redhat scientific }.each do |os|
  supports os
end

depends "yum"