require 'sinatra'

get '/' do
	@name = 'zach'
	erb :default
end
