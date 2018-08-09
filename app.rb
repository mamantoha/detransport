require 'bundler'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'json'
require_relative "lib/api_wrapper"
require_relative "lib/mapper_wrapper"

Bundler.require :default, ENV['RACK_ENV'].to_sym

class App < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::Namespace

  enable :sessions

  configure do
    set :views, 'app/views'
    set :city, 'ternopil'
  end

  configure :development do
    register Sinatra::Reloader
  end

  helpers do
    def title
      "#{settings.city.capitalize} Detransport"
    end
  end

  get "/" do
    redirect "#{settings.city}"
  end

  get "/set_city/?" do
    city = params[:city]
    settings.city = city
    redirect "/#{city}/#/"
  end

  get '/:city/?' do
    erb :index, layout: :'layouts/application'
  end

  namespace '/api' do
    before do
      headers 'Access-Control-Allow-Origin' => '*'
      content_type :json

      @api_client = ApiWrapper.new(settings.city)
      @mapper = MapperWrapper.new(settings.city)
    end

    get '/stops' do
      data = @api_client.stops

      json stops: @mapper.stops(data)
    end

    get '/stops/:id' do
      data = @api_client.show_stop(params[:id])
      json vehicles: @mapper.vehicles(data)
    end

  end
end
