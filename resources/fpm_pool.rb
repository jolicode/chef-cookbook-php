actions :create, :remove

default_action :create

attribute :user, :kind_of => String, :default => "www-data"
attribute :group, :kind_of => String, :default => "www-data"
attribute :listen, :kind_of => String, :default => ""
attribute :max_children, :kind_of => Integer, :default => 5
attribute :start_servers, :kind_of => Integer, :default => 2
attribute :min_spare_servers, :kind_of => Integer, :default => 1
attribute :max_spare_servers, :kind_of => Integer, :default => 3