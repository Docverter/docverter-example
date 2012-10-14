#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/base'
require 'docverter'
require 'net/https'
require 'uri'

class App < Sinatra::Base

  Docverter.api_key = ENV['DOCVERTER_API_KEY']

  get '/' do
    erb :index
  end

  get %r{/(.*).pdf} do |path|
    uri = URI("https://raw.github.com/#{ENV['GITHUB_REPO']}/master/#{path}.md")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    content = response.body

    res = Docverter::Conversion.run do |c|
      c.from    = "markdown"
      c.to      = "pdf"
      c.content = content
    end

    content_type "application/pdf"
    res
  end

  post '/ping' do
    'pong'
  end
end
