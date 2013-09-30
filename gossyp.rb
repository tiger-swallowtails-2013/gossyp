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

get '/' do
  # When you return a string from a sinatra route definition, it will render it
  # as HTML.
  "<a href='/auth/twitter'>Login with Twitter!</a>"
end

get '/auth/twitter/callback' do
  # This is shorthand for sending an HTTP Header of 'Location: http://yourhost.com/' and a response
  # code of 302

  redirect '/'
  # http://en.wikipedia.org/wiki/HTTP_302
end
