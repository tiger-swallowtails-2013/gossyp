$LOAD_PATH.unshift(File.expand_path('.'))
require 'gossyp'

run Sinatra::Application
