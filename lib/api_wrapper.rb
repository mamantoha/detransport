# frozen_string_literal: true

require_relative 'api/detransport_api'
require_relative 'api/lad_api'

class ApiWrapper
  attr_reader :client

  def initialize(city)
    case city
    when 'lviv'
      @client = LadAPI.new
    when 'ternopil'
      @client = DetransportAPI.new
    else
      raise 'Unknown API provider'
    end
  end

  def stops
    @client.stops
  end

  def show_stop(code)
    @client.show_stop(code)
  end
end
