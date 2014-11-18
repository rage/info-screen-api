require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/cross_origin'
require 'json'
require 'data_mapper'

require './configuration.rb'
require './message.rb'

configure do

  enable :cross_origin

  DataMapper.auto_upgrade!

end

get '/messages/?' do

  content_type :json
  Message.all.to_json(only: [ :id, :timestamp, :message ])

end

post '/messages/?' do

  Message.create(

    message: params[:message],
    timestamp: DateTime.now,
    ip: request.ip

  )

end
