enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  @user = User.find_by_name(params[:user][:name])
  if @user
    if @user.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect '/secret'
    else
      redirect '/'
    end
  else
    redirect '/'
  end
end

get '/secret' do
  erb :secret
end

get '/new_user' do
  erb :new_user
end

post '/new_user' do
  @user = User.create(params[:user])
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end
