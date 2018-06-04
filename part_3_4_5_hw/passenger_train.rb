# frozen_string_literal: true

class PassengerTrain < Train
  attr_accessor :number_of_sits

  def hitch_wagon(number_of_sits)
    wagons << PassengerWagon.new(wagons_size + 1, random_string, number_of_sits) if speed_zero?
  end

  def type
    :passenger
  end
end
