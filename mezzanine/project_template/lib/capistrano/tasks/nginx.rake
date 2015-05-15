# required variables
# - nginx_server_executable
# - nginx_server_dir
# - nginx_conf_dir
# - nginx_site_conf
# - nginx_maintenance_conf
# - nginx_pid_file
# - nginx_start_cmd
# - nginx_reload_cmd

namespace :nginx do

    def nginx_reload()
        if test "[ -e #{fetch(:nginx_pid_file)} ]"
            on roles(:all) do |h|
                execute "#{fetch(:nginx_reload_cmd)}"
            end
        else
            on roles(:all) do |h|
                execute "#{fetch(:nginx_start_cmd)}"
            end
        end
    end

    namespace :maintenance do

        desc "setup maintenance site, copy config to sites available"
        task :setup do
            on roles(:all) do
                within release_path do
                    execute :cp, "#{fetch(:nginx_conf_dir)}/maintenance/#{fetch(:nginx_site_conf)} #{fetch(:nginx_server_dir)}/sites-available/maintenance-#{fetch(:nginx_site_conf)}"
                end
            end
        end
        
        desc "symlink maintenance site to sites-enabled"
        task :enable do
            on roles(:all) do
                execute :ln, "-s #{fetch(:nginx_server_dir)}/sites-available/maintenance-#{fetch(:nginx_site_conf)} #{fetch(:nginx_server_dir)}/sites-enabled/maintenance-#{fetch(:nginx_site_conf)}"
            end
        end

        desc "unlink maintenance site in sites-enabled"
        task :disable do
            on roles(:all) do
                execute :rm, "#{fetch(:nginx_server_dir)}/sites-enabled/maintenance-#{fetch(:nginx_site_conf)}"
            end
        end
    end

    namespace :site do
        desc "setup site"
        task :setup do
            on roles(:all) do
                within release_path do
                    execute :cp, "#{fetch(:nginx_conf_dir)}/#{fetch(:nginx_site_conf)} #{fetch(:nginx_server_dir)}/sites-available/#{fetch(:nginx_site_conf)}"
                end
            end
        end

        desc "turn site off and maintenance mode on"
        task :off do
            invoke 'nginx:site:disable'
            invoke 'nginx:maintenance:enable'
            invoke 'nginx:reload'
        end

        desc "turn site on and maintenance mode off"
        task :on do
            invoke 'nginx:maintenance:disable'
            invoke 'nginx:site:enable'
            invoke 'nginx:reload_again'
        end

        desc "symlink site to sites-enabled"
        task :enable do
            on roles(:all) do
                execute :ln, "-s #{fetch(:nginx_server_dir)}/sites-available/#{fetch(:nginx_site_conf)} #{fetch(:nginx_server_dir)}/sites-enabled/#{fetch(:nginx_site_conf)}"
            end
        end

        desc "unlink site in sites-enabled"
        task :disable do
            on roles(:all) do
                execute :rm, "#{fetch(:nginx_server_dir)}/sites-enabled/#{fetch(:nginx_site_conf)}"
            end
        end
    end

    desc "reload nginx"
    task :reload do
        on roles(:all) do
            nginx_reload()
        end
    end

    desc "reload nginx"
    task :reload_again do
        on roles(:all) do
            nginx_reload()
        end
    end
end