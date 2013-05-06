require_relative 'spec_helper'

describe "jolicode-php::default" do
  # use Ubuntu to test common functionality
  context "on all platforms" do
    context "with the default attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS).converge('jolicode-php::default')
      end

      it { expect(chef_run).to include_recipe 'jolicode-php::php' }

      it "creates the php.ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'date.timezone = Europe/Paris')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'max_execution_time     = 0')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'memory_limit           = -1')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'html_errors                = Off')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'display_errors             = Off')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'upload_max_filesize  = 2M')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'post_max_size        = 8M')
        chef_run.should_not create_file_with_content('/etc/php5/cli/php.ini', 'error_log')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'expose_php = Off')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'cgi.fix_pathinfo  = 0')
      end
    end

    context "with custom attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS) do |node|
          node.set['jolicode-php']['config']['date.timezone'] = 'Europe/London'
          node.set['jolicode-php']['config']['max_execution_time'] = 30
          node.set['jolicode-php']['config']['memory_limit'] = 128
          node.set['jolicode-php']['config']['html_errors'] = "On"
          node.set['jolicode-php']['config']['display_errors'] = "On"
          node.set['jolicode-php']['config']['upload_max_filesize'] = "5M"
          node.set['jolicode-php']['config']['post_max_size'] = "10M"
          node.set['jolicode-php']['config']['error_log'] = "syslog"
          node.set['jolicode-php']['config']['expose_php'] = "On"
          node.set['jolicode-php']['config']['cgi_fix_pathinfo'] = 1
        end.converge('jolicode-php::default')
      end

      it { expect(chef_run).to include_recipe 'jolicode-php::php' }

      it "creates the php.ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'date.timezone = Europe/London')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'max_execution_time     = 30')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'memory_limit           = 128')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'html_errors                = On')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'display_errors             = On')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'upload_max_filesize  = 5M')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'post_max_size        = 10M')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'error_log                  = syslog')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'expose_php = On')
        chef_run.should create_file_with_content('/etc/php5/cli/php.ini', 'cgi.fix_pathinfo  = 1')
      end
    end
  end

  context "on Debian" do
    let(:chef_run) { ChefSpec::ChefRunner.new(DEBIAN_RUN_OPTIONS).converge('jolicode-php::default') }

    it { chef_run.should install_package 'php5-cli' }
    it { chef_run.should install_package 'php5-common' }
    it { chef_run.should create_file '/etc/php5/cli/php.ini' }
  end

  context "on CentOS" do
    let(:chef_run) { ChefSpec::ChefRunner.new(CENTOS_RUN_OPTIONS).converge('jolicode-php::default') }

    it { chef_run.should install_package 'php-cli' }
    it { chef_run.should install_package 'php-common' }
    it { chef_run.should create_file '/etc/php.ini' }
  end
end