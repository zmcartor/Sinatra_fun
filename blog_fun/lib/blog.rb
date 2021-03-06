require 'sinatra/base'
require 'ostruct'
require 'time'

class Blog < Sinatra::Base
	set :root , File.expand("../" , __FILE__)
	set :articles , []
	
	#loop through all the article files
	Dir.glob "#{root}/articles/*.md" do |file|
		#parse the file
		meta , content = File.read(file).split("\n\n" , 2)
		
		#generate metadata obj
		article = Openstruct.new(YAML.load(meta))
		
		#convert date to a time object
		article.date = Time.parse article.date_to_s
		
		#set content
		article.content = content
		article.slug = File.basename(file, '.md')

		#add the article to the list of articles in process
		articles << article

		#configure the route
		get "/#{article.slug}" do
			erb :post , :locals =>{:article => article}
		end
	end

	#sort by date
	articles.sort_by! {|art| art.date}
	articles.reverse!

	get '/' do
		erb :index
	end
end
