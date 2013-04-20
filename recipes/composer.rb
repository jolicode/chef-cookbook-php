include_recipe "jolicode-php::php"

package "curl"

case node['platform_family']
when "debian"
  package "git-core"
else
  package "git"
end

execute "composer install" do
  command "curl -s http://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer"
  creates "/usr/bin/composer"
  action :run
end

#Keep composer at the last version
execute "composer update" do
  command "composer self-update"
  action :run
end