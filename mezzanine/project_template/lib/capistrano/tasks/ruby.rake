namespace :ruby do

  desc "Install Dependencies" 
  task :install_dependencies do
    on roles(:web) do
      within fetch(:release_path) do
        execute :bundle, "install --path vendor/bundle"
      end
    end
  end

end