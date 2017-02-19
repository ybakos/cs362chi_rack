ENV['RACK_ENV'] = 'test'

require_relative '../main.rb'
require 'rack/test'
require 'test/unit'
 
class AlbumsAppTest < Test::Unit::TestCase
  include Rack::Test::Methods
 
  def app
    @test = AlbumRank.new
  end
 
  def test_albumRank_build_array
    albums = []
    File.open(File.dirname(__FILE__) + '/test_albums.txt', 'r') do |file|
      albums = file.readlines
    end
    @rankedAlbums = AlbumRank.build_array(albums)
    assert_equal 10, @rankedAlbums.length

    #Test format is correct for all
    @rankedAlbums.each do |item|
      assert(item.name.is_a?(String))
      assert(item.year.to_i.is_a?(Integer))
      assert(item.rank.to_i.is_a?(Integer))
    end

    #Test first element is like it should be
    assert_equal("Sgt. Pepper's Lonely Hearts Club Band", @rankedAlbums.at(0).name)
    assert_equal("1967", @rankedAlbums.at(0).year.chomp.strip)
    assert_equal(1, @rankedAlbums.at(0).rank)

    #Test last element is like it should be
    assert_equal("The Joshua Tree", @rankedAlbums.at(9).name)
    assert_equal("1987", @rankedAlbums.at(9).year.chomp.strip)
    assert_equal(10, @rankedAlbums.at(9).rank)

    # test some more stuff
  end
   
end
