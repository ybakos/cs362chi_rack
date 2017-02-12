ENV['RACK_ENV'] = 'test' # Super great start, now... what should be tested? (What are the requirements?)

require './lib/main.rb'
require 'rack/test'
require 'test/unit'

class AlbumsAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    AlbumRankApp.new
  end

  def test_header_is_passed_correctly
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, "Top 100 Best Albums of All Time"
  end

  def test_response_status
    get '/'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_error_status
    post '/thisPageDoesntExist'
    assert last_response.not_found?
    assert_equal 404, last_response.status
  end

end
