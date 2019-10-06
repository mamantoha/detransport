# frozen_string_literal: true

class LadMapper
  def initialize; end

  def stops(data)
    data.each_with_object([]) do |hash, memo|
      memo << {
        id: hash['id'],
        name: hash['name']
      }
    end
  end

  def vehicles(data)
    data['routes'].each_with_object([]) do |hash, memo|
      memo << {
        name: hash['title'],
        time: time_to_seconds(hash['timeLeft'])
      }
    end
  end

  private

  def time_to_seconds(str_time)
    str_time.to_i * 60
  end
end
