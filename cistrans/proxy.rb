require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require 'cgi'

configure do
  enable :cross_origin
  set :public_folder, File.dirname(__FILE__)
end

#for jquery etc
get '/:folder/:file.js' do |folder, file|
	send_file "../#{folder}/#{file}.js"
end

get '/sparqldemo' do
	send_file './sparql_demo.html'
end

get '/doquery/:query' do |query|
	content_type :json
	query_url = "http://localhost:8080/sparql/?soft-limit=5000&output=json";
	# query = CGI.escape(query)
	query = URI.escape(query)

	#probably should use NET::HTTP or something if this will be used much
	`curl -g '#{query_url}&query=#{query}'`
end
