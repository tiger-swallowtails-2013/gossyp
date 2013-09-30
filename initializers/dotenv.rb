# Heroku by default allows you to set environment variables with heroku
# config:set VARIABLE=value

# See:
# https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application

# Because of this, we don't want to load dotenv in production or staging.
# See http://www.sinatrarb.com/configuration.html#built-in-settings


unless ["production", "staging"].include? ENV['RACK_ENV']
  # dotenv allows us to store configuration variables in a .env file
  # This makes it easy to keep our secret configuration variables
  # outside of our public repo. HOORAY!
  require 'dotenv'
  Dotenv.load('.env.development')
  # https://github.com/bkeepers/dotenv#sinatra-or-plain-ol-ruby
end
