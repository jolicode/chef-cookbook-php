require_relative 'spec_helper'

describe "jolicode-php::ext-apc" do
  # use Ubuntu to test common functionality
  context "on all platforms" do
    context "with the default attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS).converge('jolicode-php::ext-apc')
      end

      it "creates the php.ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'extension           = apc.so')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.enabled         = 1')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.shm_segments    = 1')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.shm_size        = 64M')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.max_file_size   = 10M')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.stat            = 1')
      end
    end

    context "with custom attributes" do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(UBUNTU_RUN_OPTIONS) do |node|
          node.set['jolicode-php']['apc']['config']['enabled']       = "0"
          node.set['jolicode-php']['apc']['config']['shm_segments']  = "2"
          node.set['jolicode-php']['apc']['config']['shm_size']      = "128M"
          node.set['jolicode-php']['apc']['config']['max_file_size'] = "12M"
          node.set['jolicode-php']['apc']['config']['stat']          = "0"
        end.converge('jolicode-php::ext-apc')
      end

      it "creates the php.ini file with the right contents" do
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'extension           = apc.so')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.enabled         = 0')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.shm_segments    = 2')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.shm_size        = 128M')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.max_file_size   = 12M')
        chef_run.should create_file_with_content('/etc/php5/conf.d/apc.ini', 'apc.stat            = 0')
      end
    end
  end

  context "on Debian" do
    let(:chef_run) { ChefSpec::ChefRunner.new(DEBIAN_RUN_OPTIONS).converge('jolicode-php::ext-apc') }

    it { chef_run.should install_package 'php-apc' }
    it { chef_run.should create_file '/etc/php5/conf.d/apc.ini' }
  end

  context "on CentOS" do
    let(:chef_run) { ChefSpec::ChefRunner.new(CENTOS_RUN_OPTIONS).converge('jolicode-php::ext-apc') }

    it { chef_run.should install_package 'php-pecl-apc' }
    it { chef_run.should create_file '/etc/php.d/apc.ini' }
  end
end