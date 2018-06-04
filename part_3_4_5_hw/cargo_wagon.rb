# frozen_string_literal: true

class CargoWagon < Wagon
  attr_accessor :available_value, :loaded_value

  def initialize(number, producer, available_value)
    super(number, producer)
    @available_value = available_value
    @loaded_value = 0
  end

  def load_value(value_to_load)
    if (available_value - loaded_value) >= value_to_load
      self.loaded_value += value_to_load
      self.available_value -= loaded_value
      puts "Total loaded value #{loaded_value}"
    else
      puts 'Not enough available value left'
    end
  end

  def wagon_info
    { number: number, producer: producer, available_value: available_value, loaded_value: loaded_value }
  end
end
