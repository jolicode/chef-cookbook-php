require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php_test::ext-fpm" do
  include Helpers::CookbookTest

  it "creates the 'my_app' pool config file" do
    file("#{node['jolicode-php']['fpm_pool_dir']}/my_app.conf").must_exist
  end

  it "sets the right ini values" do
    file("#{node['jolicode-php']['fpm_pool_dir']}/my_app.conf").must_include("listen                  = /var/run/php5-fpm-my_app.sock")
    file("#{node['jolicode-php']['fpm_pool_dir']}/my_app.conf").must_include("pm                      = static")
    file("#{node['jolicode-php']['fpm_pool_dir']}/my_app.conf").must_include("pm.max_children         = 5")
    file("#{node['jolicode-php']['fpm_pool_dir']}/my_app.conf").must_include("pm.status_path          = /status")
  end

  it "exposes a working status page" do
    assert_sh("curl http://127.0.0.1:8095/status").must_include("my_app")
  end

end