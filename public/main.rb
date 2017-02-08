require "rack"

class AlbumsApp
	def call(env)
		albums = []

		File.open("top_100_albums.txt", "r") do |file|
			albums = file.readlines
		end

		# albums.each do |album|
		# 	puts album
		# end
		['200', {'Content-type' => 'text/html'}, [albums.to_s]]
	end

end

Rack::Handler::WEBrick.run AlbumsApp.new