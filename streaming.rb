require 'sinatra'

before do
	content_type :text
end

clients = []

get '/consume' do
	stream(:keep_open) do |connection|
		clients << connection

		#when closed, remove this connection
		connection.callback {clients.delete connection}
		
		#remove if there's an error. Log it out!
		connection.errback do
			logger.warn "Lost connection, see ya!"
			clients.delete connection
		end
	end
end

#probably not RESTful..
get '/send/:msg' do
	clients.each do |socket|
		socket << params[:msg] << "\n"
	end
	"Send #{params[:msg]} to all clients."
end
