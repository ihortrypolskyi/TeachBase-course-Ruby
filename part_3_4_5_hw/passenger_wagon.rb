# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_accessor :number_of_sits, :sits_occupied

  def initialize(number, producer, number_of_sits)
    super(number, producer)
    @number_of_sits = number_of_sits
    @sits_occupied = 0
  end

  def occupy_a_sit
    if sits_occupied < number_of_sits
      self.sits_occupied += 1
      puts 'One passenger was added to a wagon'
    else
      puts "All #{number_of_sits} sits are occupied"
    end
  end

  def sits_to_occupy
    number_of_sits - sits_occupied
  end

  def wagon_info
    { number: number, producer: producer, number_of_sits: number_of_sits, sits_occupied: sits_occupied }
  end
end
