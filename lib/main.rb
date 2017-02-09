require "rack"
require "erb"

class Album
  attr_accessor :rank, :albumName, :year

  def initialize(rank, albumName, year)
    @rank = rank
    @albumName = albumName
    @year = year
  end
end


class AlbumRank

	def initialize
    @rankArray = Array.new
  end


  def build_array(array)
    array.map.with_index do |d, i|
      albumName, year = d.split(",")
      year = year.to_i
      @rankArray << Album.new(i+1, albumName, year)
    end 
  end


  def print_data
    @rankArray.each do |item|
    	puts item.inspect
    end
  end

  def get_binding
    binding
  end

end


class AlbumRankApp

  def call(env)
    request = Rack::Request.new(env)

    albums = []

    File.open("top_100_albums.txt", "r") do |file|
      albums = file.readlines
    end

    case request.path
    when "/" then 
      rankedAlbums = AlbumRank.new
      rankedAlbums.build_array(albums)

      Rack::Response.new(render("index.html.erb"), rankedAlbums)
    #when "/orderByAlbumNameLength" then
    #when "/orderByYear" then
    #when "/orderByAlphabetical" then
    else Rack::Response.new("404 Not Found", 404)
    end
  end

  def render(template, data)
    path = File.expand_path("../views/#{template}", __FILE__)
    output = ERB.new(File.read(path))
    output.result(data.get_binding)
  end
end
