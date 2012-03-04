require 'sinatra'

#before process a route, setup response as plain txt
#setup array of viable moves.

before do
	content_type :text
	@defeat = {rock: :scissors , paper: :rock , scissors: :paper}
	@throws = @defeat.keys
end

get '/throw/:type' do

end
