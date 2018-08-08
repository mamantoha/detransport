require "json"
require "faraday"

class LadAPI
  def initialize
    url = "https://api.eway.in.ua/"
    login = ENV["EWAY_USER"]
    password = ENV["EWAY_PASSWORD"]

    @conn = Faraday.new(
      url: url,
      params: {
        login: login,
        password: password,
        city: "lviv",
        lang: "ua",
        format: "json",
        v: "1.2"
      }
    )
  end

  def stops
    file = File.read(File.expand_path('data/lviv_stops.json', __dir__))

    JSON.parse(file)
  end

  def show_stop(code)
    res = @conn.get do |req|
      req.url "/"
      req.params["function"] = "stops.GetStopInfo"
      req.params["id"] = code
    end

    JSON.parse(res.body)
  end
end
