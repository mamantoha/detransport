# frozen_string_literal: true

class DetransportMapper
  def initialize; end

  def stops(data)
    data['stops'].each_with_object([]) do |hash, memo|
      memo << {
        id: hash['id'],
        name: hash['name']
      }
    end
  end

  def vehicles(data)
    data['vehicles'].each_with_object([]) do |hash, memo|
      memo << {
        name: hash['name'],
        time: hash['time']
      }
    end
  end
end
