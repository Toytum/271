class AbstractBike

  def initialize
    puts 'No! Raise an error to prevent instantiation.'
    sadjust_suspension
    adjust_seat
    adjust_chain
  end

  def prepare
    puts 'Pumping air in tires...'
    puts 'Cleaning it up...'
    puts 'Ready!'
  end

  def adjust_suspension
    puts 'Adjusting suspension...'
  end

  def adjust_seat
    puts 'Adjusting seat....'
  end

  def adjust_chain
    puts 'Adjusting the chain...'
  end
end

class BmxBike < AbstractBike
    adjust_seat
end

class RoadBike < AbstractBike
    adjust_chain
end

class MountainBike < AbstractBike
    adjust_suspension
end

class Tricycle < AbstractBike

  def lubricate_bell
    puts 'Lubricating the bell...'
  end

end

bmx_bike = BmxBike.new
bmx_bike.adjust_seat
bmx_bike.prepare

road_bike = RoadBike.new
road_bike.adjust_chain
road_bike.prepare

mountain_bike = MountainBike.new
mountain_bike.adjust_suspension
mountain_bike.prepare

tricycle = Tricycle.new
tricycle.lubricate_bell
tricycle.prepare
