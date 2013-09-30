require 'omniauth'
require 'omniauth-twitter'

# Omniauth::Builder is Rack Middleware that standardizes how oauth responses
# are formatted for your oauth callback, as well as makes it
# easy to create links to oauth providers
use OmniAuth::Builder do
  # We are going to use twitter for logins, BECAUSE YAY TWITTER
  # You'll need to register an app at https://dev.twitter.com/
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # https://github.com/arunagw/omniauth-twitter#before-you-begin
end
