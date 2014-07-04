actions :create, :remove

default_action :create

attribute :user, :kind_of => String, :required => true
attribute :group, :kind_of => String, :required => true
attribute :listen, :kind_of => String, :default => ""
attribute :listen_owner, :kind_of => String, :default => 'www-data'
attribute :listen_group, :kind_of => String, :default => 'www-data'
attribute :listen_mode, :kind_of => Integer, :default => 0660
attribute :process_manager, :kind_of => String, :default => 'dynamic'
attribute :max_children, :kind_of => Integer, :default => 5
attribute :start_servers, :kind_of => Integer, :default => 2
attribute :min_spare_servers, :kind_of => Integer, :default => 1
attribute :max_spare_servers, :kind_of => Integer, :default => 3
attribute :max_requests, :kind_of => Integer, :default => 10000
attribute :status_path, :kind_of => String, :default => ''
attribute :set_chdir, :kind_of => String, :default => '/'
attribute :set_chroot, :kind_of => String, :default => ''
