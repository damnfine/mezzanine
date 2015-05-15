# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :web, %w{git@local.example.com}

set :deploy_to, '/opt/local/example'

set :nginx_site_conf, 'local.example.com'
set :nginx_server_dir, '/etc/nginx'
set :nginx_pid_file, '/var/run/nginx.pid'
set :nginx_start_cmd, 'sudo service nginx start'
set :nginx_reload_cmd, 'sudo service nginx reload'

set :django_settings, 'local'

set :gunicorn_config_file, 'local'
set :gunicorn_sock_file, '/tmp/local_example_gunicorn.sock'
set :gunicorn_supervisor, true

set :supervisor_config_file, 'local'
set :supervisor_sock_file, '/tmp/local_example_supervisor.sock'
set :supervisor_pid_file, '/tmp/local_example_supervisord.pid'