set :deploy_to, "/home/cuniculi/cuniculicavum.com"

set :scm, :git
set :repository, "github.cuniculi_cavum:ambethia/cuniculicavum.com.git"
set :git_enable_submodules, true
set :deploy_via, :remote_cache

role :app, "cuniculicavum.com"
role :web, "cuniculicavum.com"
role :db,  "cuniculicavum.com", :primary => true

ssh_options[:username] = "cuniculi"
set :run_method, :run

namespace :deploy do
  task :custom_symlinks do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  desc "Restart Passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with Passenger"
    task t, :roles => :app do ; end
  end
end

after  "deploy:symlink", "deploy:custom_symlinks"
after  "deploy",         "deploy:cleanup"
