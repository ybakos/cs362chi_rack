require "RackApp"

use Rack::Reloader, 0

run RackApp.new