# dotenv allows us to store configuration variables in a .env file
# This makes it easy to keep our secret configuration variables
# outside of our public repo. HOORAY!
require 'dotenv'
Dotenv.load('.env.development')
# https://github.com/bkeepers/dotenv#sinatra-or-plain-ol-ruby
