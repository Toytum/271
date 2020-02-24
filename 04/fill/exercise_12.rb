class Preparer

  def run(preparable)
    preparable.prepare
  end

end

class BmxBike
    def prepare
        clean
    end
   private
    def clean
        puts 'Cleaning...'
    end
end

class RoadBike
    def prepare
        lubricate_gears
    end
   private
    def lubricate_gears
        puts 'Lubricaing gears...'
    end
end

class MountainBike
    def prepare
        adjust_suspension
    end
   private
    def adjust_suspension
        puts 'Adjusting suspension...'
    end
end

class Tricycle
    def prepare
        adjust_seat
    end
   private
    def adjust_seat
        puts 'Adjusting seat...'
    end
end

bikes = [BmxBike.new, RoadBike.new, MountainBike.new, Tricycle.new]

employee = Employee.new

bikes.each do |bike|
  employee.prepare(bike)
end