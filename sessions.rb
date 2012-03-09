require 'sinatra'

configure do
	enable :sessions
	set :session_secret , "blargggghhh"
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

#send an attachment. the file type will be used to set the Content-Disposition header

get '/novel' do
	attachment "OHHAI.txt"
	"OH HAI, how are you??"
end
