require 'bundler'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'faraday'
require 'json'

Bundler.require :default, ENV['RACK_ENV'].to_sym

class App < Sinatra::Base
  configure do
    register Sinatra::Reloader
    register Sinatra::Namespace

    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  namespace '/api' do
    before do
      headers 'Access-Control-Allow-Origin' => '*'

      url = 'http://api.detransport.com.ua'
      @conn = Faraday.new(url: url)
    end

    get '/stops' do
      response = @conn.get('/stops/list/')

      data = JSON.parse(response.body)
      json data
    end

    get '/vehicle/:id' do
      response = @conn.post('/vehicles/info/', { stop: params[:id] })

      data = JSON.parse(response.body)
      json data
    end

  end

end
