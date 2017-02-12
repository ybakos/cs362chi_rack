require "rack" # Prefer single ticks.
require "erb"

class Album # One blank line after this.
  attr_accessor :rank, :albumName, :year # Do we say that people have "peopleNames"?

  def initialize(rank, albumName, year)
    @rank = rank
    @albumName = albumName
    @year = year
  end # One blank line after this.
end


class AlbumRank

  def self.build_array(array) # Omit the next blank line.

    rankArray = []  # Rubyists use lower_snake_case. This variable isn't necessary at all, because...
                              # I don't think this blank line belongs here.
    rankArray = array.map.with_index do |d, i|  # ... map returns an array anyway.
      albumName, year = d.split(",") # album_name. Or how about just name?
      year = year.to_i # Hmmm, why convert this to an Integer if you're never going to perform int operations on it?
      Album.new(i+1, albumName, year)
    end
    return rankArray
  end


  def print_data # Interesting. So I have to instantiate an AlbumRank object in order to call this?
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
      @rankedAlbums.sort! { |a,b| a.albumName.length <=> b.albumName.length } # See sort_by. And there's another trick using &...
      Rack::Response.new(render("index.html.erb", @rankedAlbums)) # You must like repeated code, repeated code, repeated code.

    when "/orderByYear" then
      @rankedAlbums.sort! { |a,b| a.year <=> b.year } # See sort_by. And there's another trick using &...
      Rack::Response.new(render("index.html.erb", @rankedAlbums)) # ... :)

    when "/orderAlphabetically" then
      @rankedAlbums.sort! { |a,b| a.albumName <=> b.albumName } # See sort_by. And there's another trick using &...
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
