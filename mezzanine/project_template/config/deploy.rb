# config valid only for current version of Capistrano
lock "3.4.0"

set :application, "example"
set :repo_url, "git@github.com:user/example.git"
set :user, "git"
set :branch, ENV["CIRCLE_BRANCH"] || "master"

# python variables
set :python_virtualenv_dir, "venv"
set :python_virtualenv_requirements, "requirements.txt"

# nginx variables
set :nginx_conf_dir, "deploy/nginx"

# django variables
set :django_settings_dir, "deploy/local_settings"
set :pip_requirements, "requirements.txt"
# shared directory for user uploaded files
set :linked_dirs, %w(static/media)

# gunicorn variables
set :gunicorn_config_dir, "deploy/gunicorn"

# supervisor variables
set :supervisor_virtualenv_dir, "venv"
set :supervisor_config_dir, "deploy/supervisor"

namespace :deploy do

  # install dependencies
  after :updated, "python:virtualenv:create"
  after :updated, "python:virtualenv:install_dependencies"
  # setup nginx
  after :updated, "nginx:maintenance:setup"
  after :updated, "nginx:site:setup"
  # turn on nginx maintenance mode
  after :updated, "nginx:site:off"
  # stop
  after :updated, "gunicorn:stop"
  # setup
  after :updated, "django:setup"
  after :updated, "gunicorn:setup"
  after :updated, "supervisor:setup"
  # restart
  after :updated, "supervisor:restart"
  # finally turn off nginx maintenance mode
  after :finished, "nginx:site:on"
  # in case of failure, turn on nginx site to reveal current stable site
  after :failed, "nginx:site:on"

end