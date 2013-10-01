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
