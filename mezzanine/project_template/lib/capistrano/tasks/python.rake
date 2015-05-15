# required variables
# - python_virtualenv_dir
# - python_virtualenv_requirements

namespace :python do
    namespace :virtualenv do

      task :create do
        on roles(:web) do
          within fetch(:release_path) do
            puts "create #{fetch(:python_virtualenv_dir)} dir within #{fetch(:release_path)}"
            execute :virtualenv, "#{fetch(:python_virtualenv_dir)} --no-site-packages"
          end
        end
      end

      task :install_dependencies do
        on roles(:web) do
          within fetch(:release_path) do
            puts "install #{fetch(:python_virtualenv_dir)} dependencies within #{fetch(:release_path)}"
            execute "#{fetch(:python_virtualenv_dir)}/bin/pip", "install -r #{fetch(:python_virtualenv_requirements)}"  
          end
        end
      end

    end
end