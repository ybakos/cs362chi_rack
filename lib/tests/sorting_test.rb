ENV['RACK_ENV'] = 'test'

require_relative '../main.rb'
require 'rack'
require 'rack/test'
require 'test/unit'

class SortingTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app

    AlbumRankApp.new
    #@albums = []

    #File.open(File.dirname(__FILE__) + '/test_albums.txt', 'r') do |file|
    #  @albums = file.readlines
    #end

    #@rankedAlbums = AlbumRank.build_array(@albums)

  end

  def test_sort_by_year
 
    get '/orderByYear'
    assert last_response.ok?
    puts @rankedAlbums
    assert_equal("Kind of Blue", @rankedAlbums.at(0).name)
  end

  # def test_sort_alphabetically

  #   get '/orderAlphabetically'
  #   assert last_response.ok?
  #   assert_equal("'Live' at The Apollo", @rankedAlbums.at(0).name)
  # end

  # def test_sort_by_album_title_length

  #   get '/orderByAlbumNameLength'
  #   assert last_response.ok?
  #   assert_equal("Ten", @rankedAlbums.at(0).name)
  # end

  # def test_sort_by_rank

  #   get '/'
  #   assert last_response.ok?
  #   assert_equal("Sgt. Pepper's Lonely Hearts Club Band", @rankedAlbums.at(0).name)
  # end

 end