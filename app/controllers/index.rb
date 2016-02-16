get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/logout' do
  session['user'] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

get '/register/new' do
  if User.exists?(email: params[:email])
    erb :already_registered
  elsif (params[:name] == "")
    redirect '/register_error/?error=NAME'
  elsif (params[:email] == "")
    redirect '/register_error/?error=EMAIL'
  elsif (params[:password] == "")
    redirect '/register_error/?error=PASSWORD'
  else
    password = BCrypt::Password.create(params[:password])
    new_user = User.new(name: params[:name], email: params[:email])
    new_user.password = params[:password]
    new_user.save
    @username = params[:name]
    session['user'] = @username
    redirect 'secret'
  end
end

get '/login' do
  user = User.find_by_email(params[:email])
  if (params[:name] == "")
    redirect '/register_error/?error=NAME'
  elsif (user == nil)
    erb :wrong_name
  elsif (user) && (user.password == params[:password])
    @username = user.name
    session['user'] = @username
    redirect '/secret'
  else
    erb :wrong_password
  end
end

get '/register_error/' do
  @error = params[:error]
  erb :register_error
end
