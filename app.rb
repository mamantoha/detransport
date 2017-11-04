require 'bundler'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'json'
require_relative "lib/api_wrapper"
require_relative "app/mappers/mapper_wrapper"

Bundler.require :default, ENV['RACK_ENV'].to_sym

class App < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::Namespace

  enable :sessions

  configure do
    set :views, 'app/views'
  end

  before do
    set_city
  end

  get '/' do
    erb :index, layout: :'layouts/application'
  end

  get "/set_city" do
    city = params[:city]
    session[:city] = city

    redirect "/"
  end

  namespace '/api' do
    before do
      headers 'Access-Control-Allow-Origin' => '*'
      content_type :json

      @api_client = ApiWrapper.new(session[:city]).()
      @mapper = MapperWrapper.new(session[:city]).()
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

  private

  def set_city
    session[:city] = "ternopil" unless session[:city]
  end

end
