ENV['RACK_ENV'] = 'test'

require_relative '../main.rb'
require 'test/unit'

class AlbumClassTest < Test::Unit::TestCase

  RANK = 1
  NAME = "Title"
  YEAR = 2017

  def setup
    @album = Album.new(RANK, NAME, YEAR)
  end

  def test_album_class_initializer
  	assert_equal(NAME, @album.name)
  	assert_equal(RANK, @album.rank)
  	assert_equal(YEAR, @album.year)
  end

  def test_album_responds_to_title
    assert_respond_to(@album, :name, "Album does not have a title")
  end

  def test_album_responds_to_rank
    assert_respond_to(@album, :rank, "Album does not have a title")
  end

  def test_album_responds_to_year
    assert_respond_to(@album, :year, "Album does not have a title")
  end

  def test_album_rank_must_be_greater_than_zero
    assert_raises(ArgumentError) {Album.new(0,NAME, YEAR)}
  end

  def test_album_title_can_not_be_empty_string
    assert_raises(ArgumentError) {Album.new(RANK,"", YEAR)}
  end

  
 end
