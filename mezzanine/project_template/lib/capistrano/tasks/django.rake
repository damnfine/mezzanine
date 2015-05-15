# required variables
# - django_project_dir
# - django_settings_dir
# - django_settings

# optional variables
# - django_compressor
# - compilemessages

namespace :django do

    def django(args, flags="", run_on=:all)
        on roles(run_on) do |h|
            execute "#{release_path}/venv/bin/python", "#{release_path}/manage.py #{args} #{flags}"
        end
    end

    desc "Setup Django environment"
    task :setup do
        if fetch(:django_compressor)
            invoke 'django:compress'
        end
        #invoke 'django:compilemessages'
        invoke 'django:symlink_settings'
        invoke 'django:collectstatic'
        invoke 'django:migrate'
    end

    desc "Compile Messages"
    task :compilemessages do
        if fetch :compilemessages
            django("compilemessages")
        end
    end

    desc "Run django-compressor"
    task :compress do
        django("compress")
    end

    desc "Run django's collectstatic"
    task :collectstatic do
        django("collectstatic", "--noinput")
    end

    desc "Symlink django settings to local_settings.py"
    task :symlink_settings do
        settings_path = File.join(release_path, fetch(:django_settings_dir))
        on roles(:all) do
            within release_path do
                execute :ln, " -s #{settings_path}/#{fetch(:django_settings)}.py local_settings.py"
            end
        end
    end

    desc "Run django migrations"
    task :migrate do
        if fetch(:multidb)
            django("sync_all", '--noinput', run_on=:web)
        else
            django("migrate", "--noinput", run_on=:web)
        end
    end
end