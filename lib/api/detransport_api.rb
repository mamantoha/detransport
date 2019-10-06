# frozen_string_literal: true

require 'faraday'
require 'json'

class DetransportAPI
  def initialize
    url = 'http://api.detransport.com.ua'
    @conn = Faraday.new(url: url)
  end

  def stops
    response = @conn.get('/stops/list/')
    parse_response(response)
  end

  def show_stop(id)
    response = @conn.post('/vehicles/info/', stop: id)
    parse_response(response)
  end

  private

  def parse_response(response)
    body = response.body
    JSON.parse(body)
  end
end
