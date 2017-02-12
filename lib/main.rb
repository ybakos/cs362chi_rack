require 'rack'
require 'erb'

class Album

  attr_accessor :rank, :name, :year 

  def initialize(rank, name, year)
    @rank = rank
    @name = name
    @year = year
  end 

end


class AlbumRank

  def self.build_array(array) 
    rankArray = array.map.with_index do |d, i|  
      name, year = d.split(",") 
      Album.new(i+1, name, year)
    end
    return rankArray
  end


  def self.print_data
    rankArray.each do |item|
    	puts item.inspect
    end
  end
end


class AlbumRankApp

  def call(env)
    request = Rack::Request.new(env)

    albums = [] # Note that every request will hit the filesystem and load the data from disk. (Hint: constructor)

    File.open("top_100_albums.txt", "r") do |file|
      albums = file.readlines
    end

    @rankedAlbums = AlbumRank.build_array(albums)
    # This is our front controller!
    case request.path
    when "/" then
      Rack::Response.new(render("index.html.erb", @rankedAlbums)) # You must like repeated code, repeated code, repeated code.

    when "/orderByAlbumNameLength" then
      @rankedAlbums.sort! { |a,b| a.name.length <=> b.name.length } # See sort_by. And there's another trick using &...
      Rack::Response.new(render("index.html.erb", @rankedAlbums)) # You must like repeated code, repeated code, repeated code.

    when "/orderByYear" then
      @rankedAlbums.sort! { |a,b| a.year <=> b.year } # See sort_by. And there's another trick using &...
      Rack::Response.new(render("index.html.erb", @rankedAlbums)) # ... :)

    when "/orderAlphabetically" then
      @rankedAlbums.sort! { |a,b| a.name <=> b.name } # See sort_by. And there's another trick using &...
      Rack::Response.new(render("index.html.erb", @rankedAlbums))

    else Rack::Response.new("404 Not Found", 404)
    end
  end

  def render(template, data)
    path = File.expand_path("../views/#{template}", __FILE__)
    output = ERB.new(File.read(path))
    output.result(binding)
  end # One blank line after this.
end
