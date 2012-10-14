#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/base'
require 'docverter'
require 'net/http'
require 'uri'

class App < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/:page_name.pdf' do
    uri = URI("http://raw.github.com/#{ENV['GITHUB_REPO']}/#{params[:page_name]}.md")
    content = Net::HTTP.get(uri)
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
