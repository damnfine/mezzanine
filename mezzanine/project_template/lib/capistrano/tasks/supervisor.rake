# required variable
# - supervisor_pid_file
# - supervisor_virtualenv_dir
# - supervisor_config_file

namespace :supervisor do

  desc "Setup Supervisor"
  task :setup do
    invoke 'supervisor:symlink_conf'
  end

  desc "Symlink supervisor conf to supervisord.conf"
  task :symlink_conf do
      conf_path = File.join(release_path, fetch(:supervisor_config_dir))
      on roles(:all) do
          within release_path do
              execute :ln, "-s #{conf_path}/#{fetch(:supervisor_config_file)}.conf supervisord.conf"
          end
      end
  end

  task :restart do
    on roles(:web) do

      # test if sock file exists
      if test "[ -e #{fetch(:supervisor_sock_file)} ]"
        # unlink old supervisor process
        execute :unlink, fetch(:supervisor_sock_file)
      end
      
      # test if pid file exists
      if test "[ -e #{fetch(:supervisor_pid_file)} ]"
        # kill old supervisor process
        execute :kill, "`cat #{fetch(:supervisor_pid_file)}`"
      end

      within release_path do
        # start supervisor with the specified config file
        execute "#{fetch(:supervisor_virtualenv_dir)}/bin/supervisord"
      end
    end
  end

end