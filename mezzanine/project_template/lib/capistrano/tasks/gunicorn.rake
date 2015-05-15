# required variables
# - gunicorn_config_dir
# - gunicorn_config_file
# - gunicorn_supervisor

namespace :gunicorn do

  desc "Setup gunicorn"
  task :setup do
    invoke 'gunicorn:symlink_conf'
  end

  desc "Symlink gunicorn conf to gunicorn.conf.py"
  task :symlink_conf do
    conf_path = File.join(release_path, fetch(:gunicorn_config_dir))
    on roles(:all) do
      within release_path do
        execute :ln, "-s #{conf_path}/#{fetch(:gunicorn_config_file)}.conf.py gunicorn.conf.py"
      end
    end
  end

  desc "Stop gunicorn"
  task :stop do
    on roles(:all) do
      if fetch(:gunicorn_supervisor)
        within release_path do
          execute "venv/bin/supervisorctl", "stop gunicorn"
        end
      end
      
      # test if sock file exists
      if test "[ -e #{fetch(:gunicorn_sock_file)} ]"
        # unlink old gunicorn process
        execute :unlink, fetch(:gunicorn_sock_file)
      end
    end
  end
end