# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :web, %w{git@alpha.example.com}

set :deploy_to, '/opt/alpha/example'

set :nginx_site_conf, 'alpha.example.com'
set :nginx_server_dir, '/etc/nginx'
set :nginx_pid_file, '/var/run/nginx.pid'
set :nginx_start_cmd, 'sudo service nginx start'
set :nginx_reload_cmd, 'sudo service nginx reload'

set :django_settings, 'alpha'

set :gunicorn_config_file, 'alpha'
set :gunicorn_sock_file, '/tmp/alpha_example_gunicorn.sock'
set :gunicorn_supervisor, true

set :supervisor_config_file, 'alpha'
set :supervisor_sock_file, '/tmp/alpha_example_supervisor.sock'
set :supervisor_pid_file, '/tmp/alpha_example_supervisord.pid'