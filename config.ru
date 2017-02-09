require_relative 'lib/main'

use Rack::Reloader, 0

run AlbumRankApp.new