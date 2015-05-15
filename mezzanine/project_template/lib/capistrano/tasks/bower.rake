# required variables
# bower_target_path
# bower_bin

namespace :bower do

  desc "install from bower.json"
  task :install do
    on roles(:web) do
      full_bower_target_path = "#{fetch(:release_path)}/#{fetch(:bower_target_path)}"
      within full_bower_target_path do
        execute "#{fetch(:release_path)}/#{fetch(:bower_bin)}", "install"
      end
    end
  end

end