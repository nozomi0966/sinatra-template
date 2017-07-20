require 'sinatra'
require 'sinatra/reloader'
require_relative 'db'
# Sinatra Main controller

class MainApp < Sinatra::Base
  sensor = Sensor.new
  configure :development do
    register Sinatra::Reloader
  end
  get '/' do
    'hello, world'
  end
  post '/', provides: :json do
    params = JSON.parse request.body.read
    sensor.insert(params["temperature"].to_f, params["humidity"].to_f)
  end
end
