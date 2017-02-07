require "erb"

albums = []
File.open("top_100_albums.txt", "r") do |file|
	albums = file.readlines
end

class RackApp
	def call(env)
		request = Rack::Request.new(env)

		case request.path
		when "/" then Rack::Response.new(render("index.html.erb", albums))
		else Rack::Response.new("404 Not Found", 404)
		end
		
	end

	def render(template)
		path = File.expand_path("../views/#{template}", __FILE__)
		ERB.new(File.read(path)).result(binding)
	end
end
