require 'sinatra'

configure do
	enable :sessions
end

get '/' do
	@name = 'Session robot'
	session[:blah] = "Argghhh!"
	erb :default
end

get '/session' do
	content_type :txt
	session[:blah]
end
