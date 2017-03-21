require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'faraday'
require 'json'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Namespace
  end

  namespace '/api' do
    before do
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
