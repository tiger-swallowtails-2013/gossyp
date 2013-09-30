$LOAD_PATH.unshift(File.expand_path('.'))
require 'sinatra'
# Omniauth requires cookies so it can store data across page requests
enable :sessions
# http://www.sinatrarb.com/faq.html#sessions

require 'initializers/dotenv'
require 'initializers/activerecord'
require 'initializers/omniauth'
require 'initializers/rack_flash'


class User < ActiveRecord::Base
  def self.from_auth_hash(auth_hash)
    user = User.find_or_create_by(twitter_uid: auth_hash[:uid])
    user.update_attributes(full_name: auth_hash[:info][:name])
    user
  end
end

get '/' do
  erb :home
end

get '/auth/twitter/callback' do
  flash[:notice] = "Welcome #{auth_hash[:info][:name]}"
  User.from_auth_hash(auth_hash)

  # This is shorthand for sending an HTTP Header of 'Location: http://yourhost.com/' and a response
  # code of 302

  redirect '/'
  # http://en.wikipedia.org/wiki/HTTP_302
end

get '/gossyps/new' do
  redirect '/'
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
