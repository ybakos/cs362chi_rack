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

  def self.build_array(array)

    rankArray = []

    rankArray = array.map.with_index do |d, i|
      albumName, year = d.split(",")
      year = year.to_i
      Album.new(i+1, albumName, year)
    end 
    return rankArray
  end


  def print_data
    rankArray.each do |item|
    	puts item.inspect
    end
  end
end


class AlbumRankApp

  def call(env)
    request = Rack::Request.new(env)

    albums = []

    File.open("top_100_albums.txt", "r") do |file|
      albums = file.readlines
    end

    @rankedAlbums = AlbumRank.build_array(albums)
    # This is our front controller!
    case request.path
    when "/" then 
      Rack::Response.new(render("index.html.erb", @rankedAlbums))

    when "/orderByAlbumNameLength" then
      @rankedAlbums.sort! { |a,b| a.albumName.length <=> b.albumName.length }
      Rack::Response.new(render("index.html.erb", @rankedAlbums))

    when "/orderByYear" then
      @rankedAlbums.sort! { |a,b| a.year <=> b.year }
      Rack::Response.new(render("index.html.erb", @rankedAlbums))

    when "/orderAlphabetically" then
      @rankedAlbums.sort! { |a,b| a.albumName <=> b.albumName }
      Rack::Response.new(render("index.html.erb", @rankedAlbums))

    else Rack::Response.new("404 Not Found", 404)
    end
  end

  def render(template, data)
    path = File.expand_path("../views/#{template}", __FILE__)
    output = ERB.new(File.read(path))
    output.result(binding)
  end
end
