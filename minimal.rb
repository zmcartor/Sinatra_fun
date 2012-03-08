require 'sinatra'

get '/' do
	@name = 'zach'
	erb :default
end

get '/bad' do
	halt 500
end
