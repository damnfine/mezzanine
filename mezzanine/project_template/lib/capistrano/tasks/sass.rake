# required variables
# scss_location
# css_location

namespace :sass do

  desc "Compile scss files"
  task :compile do
    on roles(:web) do
      within fetch(:release_path) do
        execute :bundle, " exec sass --update #{fetch(:scss_location)}:#{fetch(:css_location)}"
      end
    end
  end

end