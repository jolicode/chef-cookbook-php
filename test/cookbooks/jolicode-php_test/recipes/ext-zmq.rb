include_recipe "build-essential"

zeromq_tar_gz = File.join(Chef::Config[:file_cache_path], "/", "zeromq-3.2.2.tar.gz")
node.set['jolicode-php']['zmq']['lib'] = "/opt/zeromq"

remote_file zeromq_tar_gz do
  source "http://download.zeromq.org/zeromq-3.2.2.tar.gz"
end


uuid_dev_package_name = case node["platform_family"]
                        when "rhel", "fedora" then 'uuid-devel'
                        when "debian" then 'uuid-dev'
                        else 'uuid-dev' # untested, so might be wrong
                        end
                   
package uuid_dev_package_name

bash "install zeromq 3.2.2" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -zxf #{zeromq_tar_gz}
    cd zeromq-3.2.2 && ./configure --prefix=#{node['jolicode-php']['zmq']['lib']} && make && make install
  EOH
  not_if { ::FileTest.exists?("#{node['jolicode-php']['zmq']['lib']}/lib/libzmq.so") }
end
  
include_recipe "jolicode-php::ext-zmq"