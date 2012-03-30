require 'sinatra/base'

class Middleware_basic < Sinatra::Base
	get "/clear" do

		#the app variable is the wrapped sinatra endpoint that
		#uses this middleware. app.settings.app_file is our app class
		#this can be re-initialized.
		app.settings.reset!
		load app.settings.app_file
		content_type :txt
		"Ok reloaded!"
	end
end
