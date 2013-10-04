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

get '/logout' do
  logout!
  flash[:notice] = 'You have been logged out'
  redirect '/'
end


before '/gossyps*' do
  unless logged_in?
    # We don't want to evaluate any routes if the user isn't logged in
    halt 403, erb(:forbidden)
    # http://www.sinatrarb.com/intro.html#Halting
  end
end

get '/gossyps/new' do
  @gossyp = Gossyp.new
  erb :new_gossyp
end

before %r{\/gossyps\/(\d+)} do
  @gossyp = Gossyp.find(params[:captures].first)
end

get '/gossyps/:id' do
  @reaction = Reaction.new
  erb :show_gossyp
end

post '/gossyps/:id/reactions' do
  @reaction = @gossyp.reactions.create(params[:reaction])
  erb :show_gossyp
end

post '/gossyps/:id/stars' do
  @gossyp.toggle_star!(current_user)
  flash[:notice] = "You've #{starred_message(@gossyp)} #{@gossyp.title}!"
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

