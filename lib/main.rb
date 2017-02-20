require 'rack'
require 'erb'

class Album
  attr_accessor :rank, :name, :year 

  def initialize(rank, name, year)
    raise ArgumentError unless rank > 0
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

  def initialize
    @albums = []
    File.open(File.dirname(__FILE__) + '/top_100_albums.txt', 'r') do |file|
      @albums = file.readlines
    end
  end

  def call(env)
    request = Rack::Request.new(env)
    @rankedAlbums = AlbumRank.build_array(@albums)
    # This is our front controller!
    case request.path
    when "/" then
      response("index.html.erb", @rankedAlbums)
    when "/orderByAlbumNameLength" then
      @rankedAlbums.sort_by! { |a| a.name.length } 
      response("index.html.erb", @rankedAlbums)
    when "/orderByYear" then
      @rankedAlbums.sort_by!(&:year)
      response("index.html.erb", @rankedAlbums)
    when "/orderAlphabetically" then
      @rankedAlbums.sort_by!(&:name)
      response("index.html.erb", @rankedAlbums)
    else Rack::Response.new("404 Not Found", 404)
    end
  end

  def response(file, array)
    Rack::Response.new(render("#{file}", array))
  end

  def render(template, data)
    path = File.expand_path("../views/#{template}", __FILE__)
    output = ERB.new(File.read(path))
    output.result(binding)
  end

end
