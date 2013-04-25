action :install do
  execute "composer install" do
    command "composer install #{new_resource.options}"
    cwd new_resource.cwd
    action :run
    user new_resource.user
    group new_resource.group
    environment new_resource.env_vars
  end
end

action :update do
  execute "composer update" do
    command "composer update #{new_resource.options}"
    cwd new_resource.cwd
    action :run
    user new_resource.user
    group new_resource.group
    environment new_resource.env_vars
  end
end

action :create_project do
  if !new_resource.package
    raise ArgumentError, "You must provide a package option to composer resource with create_project action"
  end
  
  execute "composer create-project" do
    command "composer create-project #{new_resource.package} #{new_resource.directory} #{new_resource.version} #{new_resource.options}"
    cwd new_resource.cwd
    environment new_resource.env_vars
  end
end
