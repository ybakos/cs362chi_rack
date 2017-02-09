require "rack"

albums = []

File.open("top_100_albums.txt", "r") do |file|
  albums = file.readlines
end

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


  def buildArray(array)
    array.map.with_index do |d, i|
      albumName, year = d.split(",")
      year = year.to_i
      @rankArray << Album.new(i+1, albumName, year)
    end 
  end


  def printData
    @rankArray.each do |item|
    	puts item.inspect
    end
  end

end

test = AlbumRank.new
test.buildArray(albums)
test.printData