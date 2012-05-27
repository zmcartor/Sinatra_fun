require 'sinatra/base'
require './mid'
require 'sinatra/assetpack'
require 'yaml'
require 'koala'

class Social < Sinatra::Base

	use Middleware_basic
	register Sinatra::AssetPack

	assets {
		serve '/js',     from: 'app/js'
		serve '/css',    from: 'app/css'
		serve '/images', from: 'app/images'

		js_compression  :jsmin      # Optional
	}

	set :rdoc, :layout_engine => :erb
	set :public_folder, File.dirname(__FILE__) + '/public'
	set :port , 9000

FACEBOOK_SCOPE = 'user_likes,user_photos,user_photo_video_tags'
	# the facebook session expired! reset ours and restart the process
	error(Koala::Facebook::APIError) do
		session[:access_token] = nil
		redirect "/auth/facebook"
	end

	#helpers block. functions are available only in request blocks
	helpers do
		def authenticator
		@keys = YAML::load_file('keys.yaml')
		@authenticator ||= Koala::Facebook::OAuth.new(@keys["app_id"], @keys["secret"], url("/auth/facebook/callback"))
		end

	end


	get "/" do
		# Get base API Connection
		@graph  = Koala::Facebook::API.new(session[:access_token])

		# Get public details of current application
		@app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])

		if session[:access_token]
			@user    = @graph.get_object("me")
			@friends = @graph.get_connections('me', 'friends')
			@photos  = @graph.get_connections('me', 'photos')
			@likes   = @graph.get_connections('me', 'likes').first(4)

			# for other data you can always run fql
			@friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
		end
		erb :index
	end

	# used by Canvas apps - redirect the POST to be a regular GET
	post "/" do
		redirect "/"
	end

	# used to close the browser window opened to post to wall/send to friends
	get "/close" do
		"<body onload='window.close();'/>"
	end

	get "/sign_out" do
		session[:access_token] = nil
		redirect '/'
	end

	get "/auth/facebook" do
		session[:access_token] = nil
		redirect authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
	end

	get '/auth/facebook/callback' do
		session[:access_token] = authenticator.get_access_token(params[:code])
		redirect '/'
	end

end
