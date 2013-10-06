
unless ['production', 'staging'].include? ENV['RACK_ENV']
  require 'rspec/core/rake_task'
  namespace :spec do
    RSpec::Core::RakeTask.new(:all) do |t|
      t.pattern = "spec/**/*_{spec,feature}.rb"
    end

    RSpec::Core::RakeTask.new(:integration) do |t|
      t.pattern = "spec/integration/*_spec.rb"
    end

    RSpec::Core::RakeTask.new(:feature) do |t|
      t.pattern = "spec/feature/*_feature.rb"
    end
  end
  task :default => ["spec:all", "jasmine:ci"]
end

task :environment do
  $LOAD_PATH.unshift('.')
  require 'gossyp'
end

require 'sinatra/activerecord/rake'

# Ensure that we load the environment before doing database stuff
["db:migrate", "db:rollback", "db:schema:dump", "db:schema:load"].each do |task|
  Rake::Task[task].enhance [:environment]
end

# See: http://www.dan-manges.com/blog/modifying-rake-tasks

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
