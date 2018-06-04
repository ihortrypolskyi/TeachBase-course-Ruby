# frozen_string_literal: true

require_relative 'producer'

class Wagon
  include Producer

  attr_accessor :number, :producer

  def initialize(number, producer)
    @number = number
    @producer = producer
  end
end
