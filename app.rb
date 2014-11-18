require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'sinatra/cross_origin'
require 'data_mapper'

require './configuration.rb'
require './message.rb'

configure do

  enable :cross_origin

  DataMapper.auto_upgrade!

end

get '/messages/?' do

  json Message.all

end

post '/messages/?' do

  Message.create(message: params[:message])

end
