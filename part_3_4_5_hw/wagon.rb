require_relative 'producer'

class Wagon
  include Producer

  def initialize(number, producer)
    @number = number
    @producer = producer
  end
end