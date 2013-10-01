# We set the load path so we can avoid require_relative
$LOAD_PATH.unshift(File.expand_path('.'))
# File::expand_path - http://www.ruby-doc.org/core-2.0.0/File.html#method-c-expand_path
# $LOAD_PATH - http://www.ruby-doc.org/core-2.0/Kernel.html#method-i-require
# Array#unshift http://www.ruby-doc.org/core-2.0.0/Array.html#method-i-unshift

# Default RACK_ENV to test when we're running specs
ENV['RACK_ENV'] ||= 'test'
require 'gossyp'

require 'capybara/rspec'
require 'helpers/test_fixture_helper'
require 'helpers/feature_login_helper'

# Tell capybara that we're testing your sinatra app
# https://github.com/jnicklas/capybara#setup
Capybara.app = Sinatra::Application

# Turn on test mode fo omniauth so it doesn't actually hit twitter
OmniAuth.config.test_mode = true
# https://github.com/intridea/omniauth/wiki/Integration-Testing

# Stop logging ActiveRecord to the console
ActiveRecord::Base.logger = Logger.new('/dev/null')


RSpec.configure do |config|
  config.before do
    User.destroy_all
  end

  # This makes sure that we include the TestFixturesHelper in all of our tests
  # Making the helper functions available to everyone!
  config.include TestFixturesHelper

  # This makes sure we include the FeatureLoginHelper only in tests that we tag
  # with feature.
  config.include FeatureLoginHelper, :type => :feature

  # See: https://www.relishapp.com/rspec/rspec-core/v/2-14/docs/helper-methods/define-helper-methods-in-a-module
  # For the official docs on how to include helpers
end
