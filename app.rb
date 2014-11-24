require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/cross_origin'
require 'json'
require 'data_mapper'
require 'open-uri'
require 'nokogiri'

require './configuration.rb'
require './notification.rb'

configure do

  enable :cross_origin

  DataMapper.auto_upgrade!

end

# Notifications

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

# Coverages

get '/coverages/?' do

  content_type :json

  repositoryNodes = Nokogiri::HTML(open('https://coveralls.io/r/rage/')).css('.repoOverview')

  repositories = repositoryNodes.inject([]) do | array, element |

    headerNode = element.css('.repoChartInfo h1 a')
    coverageElement = element.css('.repoChartInfo .coverageText')

    array << {

      name: "#{headerNode[0].text}/#{headerNode[1].text}",
      coverage: coverageElement.text,
      level: coverageElement.attr('class').text.split(' ')[0].split('-')[1]

    }

  end

  repositories.to_json

end
