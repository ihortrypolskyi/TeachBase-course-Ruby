class PassengerTrain < Train
  def hitch_wagon
    wagons << PassengerWagon.new(wagons_size + 1, random_string) if speed_zero?
  end

  def type
    :passenger
  end
end