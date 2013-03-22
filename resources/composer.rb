actions :install, :update, :create_project

default_action :install

attribute :cwd, :kind_of => String, :required => true
attribute :user, :kind_of => String
attribute :group, :kind_of => String
attribute :package, :kind_of => String
attribute :options, :kind_of => String, :default => ''
attribute :version, :kind_of => String, :default => "-sstable"
attribute :directory, :kind_of => String, :default => ""