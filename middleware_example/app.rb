require 'sinatra/base'
require './mid'

class BaseApp < Sinatra::Base
	#this is our middleware class in mid.rb
	use Middleware_basic

	set :box_of_stuff , []

	get '/' do
		content_type :txt
		"Hello, this is a box."
	end

	get '/inbox/:thing' do
		settings.box_of_stuff << params[:thing]
		content_type :txt
		"Thanks! I've added #{params[:thing]}"
		"Things in the box now: #{settings.box_of_stuff.inspect}"
	end

end
