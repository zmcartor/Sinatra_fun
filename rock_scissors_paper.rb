require 'sinatra'

#before process a route, setup response as plain txt
#setup array of viable moves.

before do
	content_type :text
	@defeat = {rock: :scissors , paper: :rock , scissors: :paper}
	@throws = @defeat.keys
end

get '/throw/:type' do
	player_throw = params[:type].to_sym
	if !@throws.include? player_throw
		halt 403, "Sorry, throw #{:type} is not a valid move"
	end

	#select random throw for app
	computer_throw = @throws.sample()

	if player_throw == computer_throw
		"Tie. Try again!"
	elsif computer_throw == @defeat[player_throw]
		"Good job, you WIN"
	else
		"Sorry. Computer beat your #{player_throw} with #{computer_throw}"
	end
end
