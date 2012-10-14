require 'app'
require 'rack/force_domain'
use Rack::ShowExceptions
use Rack::ForceDomain, ENV["DOMAIN"]
run App.new