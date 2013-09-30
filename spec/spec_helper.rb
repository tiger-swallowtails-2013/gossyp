# We set the load path so we can avoid require_relative
$LOAD_PATH.unshift(File.expand_path('.'))
# File::expand_path - http://www.ruby-doc.org/core-2.0.0/File.html#method-c-expand_path
# $LOAD_PATH - http://www.ruby-doc.org/core-2.0/Kernel.html#method-i-require
# Array#unshift http://www.ruby-doc.org/core-2.0.0/Array.html#method-i-unshift

# We require our app so that we have access to Sinatra::Application for capybara
require 'gossyp'

require 'capybara/rspec'

# Tell capybara that we're testing your sinatra app
# https://github.com/jnicklas/capybara#setup
Capybara.app = Sinatra::Application

# Turn on test mode fo omniauth so it doesn't actually hit twitter
OmniAuth.config.test_mode = true
# https://github.com/intridea/omniauth/wiki/Integration-Testing

# Stop logging ActiveRecord to the console
ActiveRecord::Base.logger = Logger.new('/dev/null')
