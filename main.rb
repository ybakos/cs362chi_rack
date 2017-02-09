require "rack"

class Album

	attr_reader :title, :rank, :year

	def initialize(title, year, rank)
		@title = title
		@rank = rank
		@year = year
	end

  def to_s
    "#{title} #{rank} #{year}"
  end

  def self.build(array)
    albums = []

    albums = array.map.with_index do |d, i|
      components = d.split(",")
      Album.new(components[0], components[1], i + 1)
    end
    return albums
  end

  def self.print_data(array)
    info = []
    array.each do |album|
      info << album.title
      info << album.year
      info << album.rank
    end
    return info
  end
end

class AlbumsApp
	def call(env)
		data = []

		File.open("top_100_albums.txt", "r") do |file|
			data = file.readlines
		end

    albums = Album.build(data)
    info = Album.print_data(albums)

		# albums.each do |album|
		# 	puts album
		# end
		['200', {'Content-type' => 'text/html'}, [info.to_s]]
	end
end

#Rack::Handler::WEBrick.run AlbumsApp.new