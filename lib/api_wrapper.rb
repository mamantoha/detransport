require_relative "detransport_api"
require_relative "lad_api"

class ApiWrapper
  attr_reader :client

  def initialize(city)
    case city
    when "lviv"
      @client = LadAPI.new
    when "ternopil"
      @client = DetransportAPI.new
    else
      raise "Unknown API provider"
    end
  end

  def call
    @client
  end
end
