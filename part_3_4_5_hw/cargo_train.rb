class CargoTrain < Train
  def hitch_wagon
    wagons << CargoWagon.new(wagons_size + 1, random_string) if speed_zero?
  end

  def type
    :cargo
  end
end