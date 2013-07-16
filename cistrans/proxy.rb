require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require 'cgi'
require 'zlib'

configure do
  enable :cross_origin
  set :public_folder, File.dirname(__FILE__)
  set :cache_queries, true
  set :cached_responses, {}
  set :endpoint_address, "http://50.116.40.22:8080/sparql"
end

#for jquery etc
get '/:folder/:file.js' do |folder, file|
	send_file "../#{folder}/#{file}.js"
end

get '/sparqldemo' do
	send_file './sparql_demo.html'
end

#probably should use NET::HTTP or something if portability is needed
get '/doquery/:query' do |query|
	content_type :json
	query_url = "#{settings.endpoint_address}/?soft-limit=5000&output=json";
	query = CGI.escape(query)
	if settings.cache_queries
		encoded_query = Zlib::Deflate.deflate(query)
		if settings.cached_responses.keys.include?(encoded_query)
			response = IO.read("./cache/#{settings.cached_responses[encoded_query]}")
			response
		else
			response = `curl -g '#{query_url}&query=#{query}'`
			filename = "#{Time.now.to_i}#{(rand*100).to_i}.json"
			open("./cache/#{filename}",'w'){|f| f.write(response)}
			settings.cached_responses[encoded_query]=filename
			response
		end
	else
		`curl -g '#{query_url}&query=#{query}'`
	end
end
