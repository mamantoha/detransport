require "json"
require "faraday"

class LadAPI

  def initialize
    url = "http://82.207.107.126:13541"
    @conn = Faraday.new(url: url)
  end

  def stops
    path = "/SimpleRIDE/LAD/SM.WebApi/api/stops"
    do_request(path)
  end

  def routes
    path = "/SimpleRide/LAD/SM.WebApi/api/CompositeRoute"
    do_request(path)
  end

  def show_stop(code)
    path = "/SimpleRIDE/LAD/SM.WebApi/api/stops/?code=#{code}"
    do_request(path)
  end

  def show_route(code)
    path = "/SimpleRIDE/LAD/SM.WebApi/api/CompositeRoute/?code=#{code}"
    do_request(path)
  end

  private

  def do_request(path)
    res = @conn.get do |req|
      req.url path
      req.headers["Accept"] = "application/xml"
    end

    parse_response(res)
  end

  def parse_response(response)
    regexp = /<string xmlns=\"http:\/\/schemas.microsoft.com\/2003\/10\/Serialization\/\">(.*)<\/string>/
    json = response.body.match(regexp)[1]
    JSON.parse(json)
  end
end
