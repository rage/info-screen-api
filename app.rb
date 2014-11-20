require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/cross_origin'
require 'json'
require 'data_mapper'

require './configuration.rb'
require './notification.rb'

configure do

  enable :cross_origin

  DataMapper.auto_upgrade!

end

get '/notifications/?' do

  content_type :json
  Notification.all(order: :timestamp.desc).to_json(only: [ :id, :timestamp, :message ])

end

post '/notifications/?' do

  Notification.create(

    message: params[:message],
    timestamp: DateTime.now,
    ip: request.ip

  )

end
