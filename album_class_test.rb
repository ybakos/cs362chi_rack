ENV['RACK_ENV'] = 'test'

require './lib/main.rb'
require 'rack/test'
require 'test/unit'

class AlbumClassTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Album.new
  end

  def test_album_class_initializer
  	rank = "1"
  	name = "Title"
  	year = "2017"

  	test = Album.new(rank, name, year)

  	assert_equal("Title", test.name)
  	assert_equal("1", test.rank)
  	assert_equal("2017", test.year)
  end
  
 end
