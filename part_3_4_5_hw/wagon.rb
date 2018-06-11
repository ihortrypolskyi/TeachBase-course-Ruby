# frozen_string_literal: true

require_relative 'producer'

class Wagon
  include Producer
  include Validation

  attr_accessor :number, :producer

  validate :producer, :presence
  validate :producer, :type, String
  validate :number, :format, /[A-Z]{0,3}/

  def initialize(number, producer)
    @number = number
    @producer = producer
  end
end
