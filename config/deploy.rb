if ENV['DEPLOY'] == 'PRODUCTION'
    puts "*** Deploying to the PRODUCTION servers!"
    role :web, "argon.ath.cx"
    role :app, "argon.ath.cx"
    role :db,  "argon.ath.cx", :primary => true

    set :deploy_target, 'production'
else
    puts "*** Deploying to the STAGING server!"
    role :web, "argon.ath.cx"
    role :app, "argon.ath.cx"
    role :db,  "argon.ath.cx", :primary => true
    
    set :deploy_target, 'staging'
end

set :deploy_to, "/var/www/taskmanager/#{deploy_target}"
set :repository, "git://github.com/codeprimate/taskmanager.git"
set :scm, :git

set :user, "bevo"
set :password, ""

set :use_sudo, false
set :runner, nil
set :start_via, :run
set :restart_via, :run
set :stop_via, :run
set :keep_releases, 2
set :deploy_via, :remote_cache
set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"


#task :restart do
#    deploy.mongrel.restart
#end
#
#task :start do
#    deploy.mongrel.start
#end
#
#task :stop do
#     deploy.mongrel.stop
#end
#
#namespace :deploy do
#
#    task :after_update_code, :roles => [:web, :app] do
#        puts " * Configure #{deploy_target} database.yml"
#        run "cp #{release_path}/config/database.yml.#{deploy_target} #{release_path}/config/database.yml"
#
#        puts " * Configure #{deploy_target} cluster config"
#        run "cp #{release_path}/config/mongrel_cluster.yml.#{deploy_target} #{release_path}/config/mongrel_cluster.yml"
#        run "export RAILS_ROOT=#{deploy_to}/current"
#    end
#
#    namespace :mongrel do
#        [ :stop, :start, :restart ].each do |t| 
#          desc "#{t.to_s.capitalize} the mongrel appserver"
#          task t, :roles => :app do
#            invoke_command "mongrel_rails cluster::#{t.to_s} -C #{mongrel_conf}", :via => run_method
#          end
#        end
#    end
#
#    desc "Custom restart task for mongrel cluster"
#    task :restart, :roles => :app, :except => { :no_release => true } do
#        deploy.mongrel.restart
#    end
#
#    desc "Custom start task for mongrel cluster"
#    task :start, :roles => :app do
#        deploy.mongrel.start
#    end
#
#    desc "Custom stop task for mongrel cluster"
#    task :stop, :roles => :app do
#        deploy.mongrel.stop
#    end
#
#end
