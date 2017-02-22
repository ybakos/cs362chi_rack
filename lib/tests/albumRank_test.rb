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
    
 
  def test_that_first_album_is_first_album_in_readin_file
    assert_equal("Sgt. Pepper's Lonely Hearts Club Band", @rankedAlbums.at(0).name)
    assert_equal("1967", @rankedAlbums.at(0).year.chomp.strip)
    assert_equal(1, @rankedAlbums.at(0).rank)
  end

  def test_last_album_in_readin_file_is_last_album
    #Test last element is like it should be
    assert_equal("The Joshua Tree", @rankedAlbums.at(9).name)
    assert_equal("1987", @rankedAlbums.at(9).year.chomp.strip)
    assert_equal(10, @rankedAlbums.at(9).rank)
  end
   
  end
   
end
