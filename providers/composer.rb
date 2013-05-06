action :install do
  execute "composer install" do
    command "composer install #{new_resource.options}"
    cwd new_resource.cwd
    action :run
    user new_resource.user
    group new_resource.group
    environment new_resource.env_vars
  end

  new_resource.updated_by_last_action(true)
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

  new_resource.updated_by_last_action(true)
end

action :create_project do
  if !new_resource.package
    raise ArgumentError, "You must provide a package option to composer resource with create_project action."
  end

  if !Dir.exists?(new_resource.directory) || (Dir.entries(new_resource.directory) - %w{ . .. }).empty?
    execute "composer create-project" do
      command "composer create-project #{new_resource.package} #{new_resource.directory} #{new_resource.version} #{new_resource.options}"
      cwd new_resource.cwd
      environment new_resource.env_vars
    end
  else
    Chef::Log.warn "Directory #{new_resource.directory} exists and not empty, project #{new_resource.package} will not be installed."
  end

  new_resource.updated_by_last_action(true)
end
