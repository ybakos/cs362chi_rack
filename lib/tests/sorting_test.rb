ENV['RACK_ENV'] = 'test'

require_relative '../main.rb'
require 'rack/test'
require 'test/unit'

class SortingTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    AlbumRankApp.new
  end

  def test_sort_by_year
  	albums = []

    File.open(File.dirname(__FILE__) + '/top_100_albums.txt', 'r') do |file|
      albums = file.readlines
    end
     
    @rankedAlbums = AlbumRank.build_array(albums)

    get '/orderByYear'
    assert last_response.ok?
    assert_equal("Kind of Blue", @rankedAlbums.at(0).name)
  end

  def test_sort_alphabetically
    albums = []

    File.open("top_100_albums.txt", "r") do |file|
      albums = file.readlines
    end
     
    @rankedAlbums = AlbumRank.build_array(albums)

    get '/orderAlphabetically'
    assert last_response.ok?
    assert_equal("'Live' at The Apollo", @rankedAlbums.at(0).name)
  end

  def test_sort_by_album_title_length
    albums = []

    File.open(File.dirname(__FILE__) + '/top_100_albums.txt', 'r') do |file|
      albums = file.readlines
    end
     
    @rankedAlbums = AlbumRank.build_array(albums)

    get '/orderByAlbumNameLength'
    assert last_response.ok?
    assert_equal("Ten", @rankedAlbums.at(0).name)
  end

  def test_sort_by_rank
    albums = []

    File.open(File.dirname(__FILE__) + '/top_100_albums.txt', 'r') do |file|
      albums = file.readlines
    end
     
    @rankedAlbums = AlbumRank.build_array(albums)

    get '/'
    assert last_response.ok?
    assert_equal("Sgt. Pepper's Lonely Hearts Club Band", @rankedAlbums.at(0).name)
  end

 end