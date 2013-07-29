require_relative 'spec_helper'

describe "jolicode-php::ext-fpm" do
  # use Ubuntu to test common functionality
  context "on all platforms" do
    context "with the default attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS).converge('jolicode-php::ext-fpm')
      end

      it "creates the php-fpm ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'date.timezone = Europe/Paris')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'max_execution_time     = 0')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'memory_limit           = -1')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'html_errors                = Off')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'display_errors             = Off')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'upload_max_filesize  = 2M')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'post_max_size        = 8M')
        chef_run.should_not create_file_with_content('/etc/php5/fpm/php.ini', 'error_log')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'expose_php = Off')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'cgi.fix_pathinfo  = 0')
      end

      it "creates the php-fpm config file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'error_log                   = /var/log/php5-fpm.log')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'syslog.facility             = daemon')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'syslog.ident                = php-fpm')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'log_level                   = notice')
      end
    end

    context "with custom attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS) do |node|
          node.set['jolicode-php']['fpm']['php-config']['date.timezone'] = 'Europe/London'
          node.set['jolicode-php']['fpm']['php-config']['max_execution_time'] = 30
          node.set['jolicode-php']['fpm']['php-config']['memory_limit'] = 128
          node.set['jolicode-php']['fpm']['php-config']['html_errors'] = "On"
          node.set['jolicode-php']['fpm']['php-config']['display_errors'] = "On"
          node.set['jolicode-php']['fpm']['php-config']['upload_max_filesize'] = "5M"
          node.set['jolicode-php']['fpm']['php-config']['post_max_size'] = "10M"
          node.set['jolicode-php']['fpm']['php-config']['error_log'] = "syslog"
          node.set['jolicode-php']['fpm']['php-config']['expose_php'] = "On"
          node.set['jolicode-php']['fpm']['php-config']['cgi_fix_pathinfo'] = 1

          node.set['jolicode-php']['fpm']['config']['error_log'] = "syslog"
          node.set['jolicode-php']['fpm']['config']['syslog_facility'] = "local1"
          node.set['jolicode-php']['fpm']['config']['syslog_ident'] = "my-fpm"
          node.set['jolicode-php']['fpm']['config']['log_level'] = "warn"
        end.converge('jolicode-php::ext-fpm')
      end

      it "creates the php.ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'date.timezone = Europe/London')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'max_execution_time     = 30')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'memory_limit           = 128')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'html_errors                = On')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'display_errors             = On')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'upload_max_filesize  = 5M')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'post_max_size        = 10M')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'error_log                  = syslog')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'expose_php = On')
        chef_run.should create_file_with_content('/etc/php5/fpm/php.ini', 'cgi.fix_pathinfo  = 1')
      end

      it "creates the php-fpm config file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'error_log                   = syslog')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'syslog.facility             = local1')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'syslog.ident                = my-fpm')
        chef_run.should create_file_with_content('/etc/php5/fpm/php-fpm.conf', 'log_level                   = warn')
      end
    end
  end

  context "on Debian" do
    let(:chef_run) do
      ChefSpec::ChefRunner.new(DEBIAN_RUN_OPTIONS) do |node|
        node.set['jolicode-php']['dotdeb'] = true
      end.converge('jolicode-php::ext-fpm')
    end

    it { chef_run.should install_package 'php5-fpm' }
    it { chef_run.should create_file '/etc/php5/fpm/php.ini' }
    it { chef_run.should create_file '/etc/php5/fpm/php-fpm.conf' }
  end

  context "on CentOS" do
    let(:chef_run) { ChefSpec::ChefRunner.new(CENTOS_RUN_OPTIONS).converge('jolicode-php::ext-fpm') }

    it { chef_run.should install_package 'php-fpm' }
    # It will not attempt to create another php.ini file - as there's only one php.ini on RedHat
    it { chef_run.should create_file '/etc/php-fpm.conf' }
  end
end