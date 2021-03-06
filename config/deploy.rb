# config valid only for Capistrano 3.1
# lock '3.1.0'


set :stages, %w(development)
set :default_stage, "development"
set :user, "deploy"
# set :application, '52.193.116.211'
set :repo_url, 'git@bitbucket.org:sandy1987/meridukan.git'
set :deploy_to, "/home/deploy/MeriDookan"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

set :user, "deploy"   
role :app, "139.59.5.60"
role :web, "139.59.5.60"
role :db,  "139.59.5.60",:primary => true

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  # desc 'Runs rake import_dump:app'
  # task :app => [:set_rails_env] do
  #   on primary fetch(:import_role) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, "import_dump:app RAILS_ENV=#{fetch(:rails_env)}"
  #       end
  #     end
  #   end
  # end
end

