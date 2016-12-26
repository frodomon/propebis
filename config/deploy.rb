# Change these
server '138.197.47.34', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:frodomon/propebis.git'
set :application,     'propebis'
set :user,            'propebis'
set :puma_threads,    [1, 6]
set :puma_workers,    1

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :rails_env,       "production"
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

before 'deploy:starting', 'db:configure'
before "deploy:assets:precompile", 'db:symlink'

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    set :database_username do
      "propebis"
    end

    set :database_password do
      ask('Enter the database password:', 'default', echo: false)
    end

    db_config = <<-EOF
      default: &default
        adapter: postgresql
        encoding: utf8
        pool: 5
        reconnect: false
        username: #{fetch(:database_username)}
        password: #{fetch(:database_password)}

      development:
        database: #{fetch(:application)}_development
        <<: *default
      test:
        database: #{fetch(:application)}_test
        <<: *default
      production:
        database: #{fetch(:application)}_production
        <<: *default
    EOF

    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
    end
    put File.write(db_config, "#{shared_path}/config/database.yml")
end

  desc "Make symlink for database yaml"
  task :symlink do
    on roles(:app) do
      execute "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma