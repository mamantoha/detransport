class LadMapper

  def initialize
  end

  def stops(data)
    data.each_with_object([]) do |hash, memo|
      memo << {
        id: hash["Code"],
        name: "#{hash['Name']} (#{hash['Code']})",
      }
    end
  end

  def vehicles(data)
    data.each_with_object([]) do |hash, memo|
      memo << {
        name: hash["RouteName"],
        time: hash["TimeToPoint"],
      }
    end
  end
end
