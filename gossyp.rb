$LOAD_PATH.unshift(File.expand_path('.'))

# Default the RACK_ENV to development unless it's explicitely specified
ENV['RACK_ENV'] ||= 'development'
require 'sinatra'

# Omniauth requires cookies so it can store data across page requests
enable :sessions
# http://www.sinatrarb.com/faq.html#sessions

require 'initializers/dotenv'
require 'initializers/activerecord'
require 'initializers/omniauth'
require 'initializers/rack_flash'
require 'models'
require 'routes'
require 'helpers'
