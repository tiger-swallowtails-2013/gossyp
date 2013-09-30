require 'sinatra'

# dotenv allows us to store configuration variables in a .env file
# This makes it easy to keep our secret configuration variables
# outside of our public repo. HOORAY!
require 'dotenv'
Dotenv.load('.env.development')
# https://github.com/bkeepers/dotenv#sinatra-or-plain-ol-ruby



require 'omniauth'
require 'omniauth-twitter'

# Omniauth requires cookies so it can store data across page requests
use Rack::Session::Cookie

# Omniauth::Builder is Rack Middleware that standardizes how oauth responses
# are formatted for your oauth callback, as well as makes it
# easy to create links to oauth providers
use OmniAuth::Builder do
  # We are going to use twitter for logins, BECAUSE YAY TWITTER
  # You'll need to register an app at https://dev.twitter.com/
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # https://github.com/arunagw/omniauth-twitter#before-you-begin
end

# rack-flash let's me store data in a hash across requests; as well as cleans
# out the data when it's read. This makes it easy to show a message once and
# only once
require 'rack-flash'
use Rack::Flash
# https://github.com/nakajima/rack-flash#sinatra

get '/' do
  # When you return a string from a sinatra route definition, it will render it
  # as HTML.

  erb :home
end

get '/auth/twitter/callback' do
  flash[:notice] = "Welcome #{auth_hash[:info][:name]}"

  # This is shorthand for sending an HTTP Header of 'Location: http://yourhost.com/' and a response
  # code of 302

  redirect '/'
  # http://en.wikipedia.org/wiki/HTTP_302
end

# Sinatra helpers create methods that are available to routes *and* views in
# sinatra
helpers do

  # I am lazy and don't like typing env['omniauth.auth'] all the time.
  # So I made an auth_hash helper
  def auth_hash
    env['omniauth.auth']
  end
end
