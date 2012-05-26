require 'sinatra/base'
require './mid'
class Social < Sinatra::Base

	use Middleware_basic

	set :rdoc, :layout_engine => :erb
	set :public_folder, File.dirname(__FILE__) + '/public'

	set :blah , 0

	get '/' do
		'oks then'
	end


end

