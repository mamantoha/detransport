require_relative "mappers/detransport_mapper"
require_relative "mappers/lad_mapper"

class MapperWrapper
  def initialize(city)
    case city
    when "lviv"
      @mapper = LadMapper.new
    when "ternopil"
      @mapper = DetransportMapper.new
    else
      raise "Unknown mapper"
    end
  end

  def call
    @mapper
  end

end
