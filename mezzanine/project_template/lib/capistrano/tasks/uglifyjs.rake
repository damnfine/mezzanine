# required variable
# - js_location
# - js_name
# - js_min_location
# - js_min_name
# - js_map_name

namespace :uglifyjs do

  desc "compile js files"
  task :compile do
    on roles(:web) do
      within fetch(:release_path) do
        execute :bundle, " exec ./node_modules/.bin/uglifyjs #{fetch(:js_location)}/#{fetch(:js_name)} -o #{fetch(:js_min_location)}/#{fetch(:js_min_name)} --source-map #{fetch(:js_min_location)}/#{fetch(:js_map_name)} --source-map-url #{fetch(:js_map_name)}"
      end
    end
  end

end