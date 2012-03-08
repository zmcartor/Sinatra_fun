require 'sinatra'


before '/' do
	@name = 'robot sinatra!'
end

get '/' do
	@name = 'zach' if @name.nil?
	erb :default
end

after '/' do
	'see you later!'
end

get '/bad' do
	halt 500
end

#creating custom headers
#simply takes a hash of values.

get '/headers' do
	headers 'foo'=>'bar' , 'hello' => 'there'
	'headers set have fun!'
end


not_found do
	content_type :txt
	'whoa sorry.'
end
