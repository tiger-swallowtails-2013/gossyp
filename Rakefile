$LOAD_PATH.unshift('.')
require 'gossyp'
require 'sinatra/activerecord/rake'

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
  task :default => "spec:all"
end
