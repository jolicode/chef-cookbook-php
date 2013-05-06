node.set[:zeromq][:src_version]        = "3.2.2"
node.set[:zeromq][:src_mirror]         = "http://download.zeromq.org/zeromq-3.2.2.tar.gz"
node.set[:zeromq][:install_dir]        = "/opt/zeromq"
node.set['jolicode-php']['zmq']['lib'] = "/opt/zeromq"
  
include_recipe "zeromq"
include_recipe "jolicode-php::ext-zmq"