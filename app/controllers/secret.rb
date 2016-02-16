before '/secret/*' do
  redirect '/' if session['user'] == nil
end

get '/secret/' do
  erb :secret
end
