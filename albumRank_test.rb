ENV['RACK_ENV'] = 'test'

require './lib/main.rb'
require 'rack/test'
require 'test/unit'
 
class AlbumsAppTest < Test::Unit::TestCase
  include Rack::Test::Methods
 
  def app
    @test = AlbumRank.new
  end
 
  def test_albumRank_build_array
    albums = []

    File.open("test_albums.txt", "r") do |file|
      albums = file.readlines
    end
     
    @rankedAlbums = AlbumRank.build_array(albums)

    assert_equal 10, @rankedAlbums.length
    # test some mroe stuff
  end 
end