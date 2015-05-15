# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :web, %w{git@beta.example.com}

set :deploy_to, '/opt/beta/example'

set :nginx_site_conf, 'beta.example.com'
set :nginx_server_dir, '/etc/nginx'
set :nginx_pid_file, '/var/run/nginx.pid'
set :nginx_start_cmd, 'sudo service nginx start'
set :nginx_reload_cmd, 'sudo service nginx reload'

set :django_settings, 'beta'

set :gunicorn_config_file, 'beta'
set :gunicorn_sock_file, '/tmp/beta_example_gunicorn.sock'
set :gunicorn_supervisor, true

set :supervisor_config_file, 'beta'
set :supervisor_sock_file, '/tmp/beta_example_supervisor.sock'
set :supervisor_pid_file, '/tmp/beta_example_supervisord.pid'