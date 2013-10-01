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


class Gossyp < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true
end

class User < ActiveRecord::Base
  has_many :gossyps
  def self.from_auth_hash(auth_hash)
    user = User.find_or_create_by(twitter_uid: auth_hash[:uid])
    user.update_attributes(full_name: auth_hash[:info][:name])
    user
  end
end

get '/' do
  if logged_in?
    @gossyps = Gossyp.all
  else
    @gossyps = []
  end
  erb :home
end

get '/auth/twitter/callback' do
  flash[:notice] = "Welcome #{auth_hash[:info][:name]}"
  user = User.from_auth_hash(auth_hash)
  session[:user_id] = user.id
  # This is shorthand for sending an HTTP Header of 'Location: http://yourhost.com/' and a response
  # code of 302

  redirect '/'
  # http://en.wikipedia.org/wiki/HTTP_302
end

get '/gossyps/new' do
  redirect '/' unless logged_in?
  @gossyp = Gossyp.new
  erb :new_gossyp
end

get '/gossyps/:id' do
  @gossyp = Gossyp.find(params[:id])
  erb :show_gossyp
end

post '/gossyps' do
  @gossyp = current_user.gossyps.create(params["gossyp"])
  if @gossyp.valid?
    flash[:notice] = "You've started a Gossyp about #{@gossyp.title}"
    redirect '/'
  else
    erb :new_gossyp
  end
end


# Sinatra helpers create methods that are available to routes *and* views in
# sinatra
helpers do

  # I am lazy and don't like typing env['omniauth.auth'] all the time.
  # So I made an auth_hash helper
  def auth_hash
    env['omniauth.auth']
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end
end
