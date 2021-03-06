require "rvm/capistrano"
require "bundler/capistrano"

load 'deploy/assets'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, 'tshirtua'

# RVM details:
set :using_rvm, true
set :rvm_ruby_string, '1.9.3@tshirtua'

# SCM details:
set :scm, 'git'
set :scm_verbose, true
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :repository, "git@github.com:pashka4281/spree-test.git"
set :branch, "master"

set :user, 'ubuntu'
set :use_sudo, false
set :stack, :passenger

# server "166.78.137.216", :web, :app, :db, :primary => true
server "surveyskitchen.com", :web, :app, :db, :primary => true
set :keep_releases, 3
set :deploy_to, '/www/tshirtua/'
set :bundle_without, [:test, :development]

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared_stuff do
  	{
		'database_tshirtua.yml' => '/config/database.yml',
    'tshirtua_product_images' => '/public/spree/products'
  	}.each do |key, val|
  		run "ln -nfs /shared/#{key} #{release_path}#{val}"
  	end
  end
  #compiling assets only in case some asset was changed from the last commit
  # namespace :assets do
  #   task :precompile, :roles => :web, :except => { :no_release => true } do
  #     # run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile} and return unless File.directory?(latest_release)
      
  #     from = source.next_revision(current_revision)
  #     if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #       run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
  #     else
  #       logger.info "Skipping asset pre-compilation because there were no asset changes"
  #     end
  #   end
  # end
end

after "deploy:update_code", "deploy:migrate"
after "deploy:update", "deploy:cleanup"
after "deploy:finalize_update", "deploy:symlink_shared_stuff"