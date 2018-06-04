# frozen_string_literal: true

class CargoTrain < Train
  def hitch_wagon(wagons_number)
    return 'Stop the train first' unless speed_zero?

    wagons << CargoWagon.new(wagons_size + 1, random_string, wagons_number)
  end

  def type
    :cargo
  end
end
