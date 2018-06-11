=begin
  Класс Train (Поезд):
  Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  Может набирать скорость
  Может показывать текущую скорость
  Может тормозить (сбрасывать скорость до нуля)
  Может показывать количество вагонов
  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  Может принимать маршрут следования (объект класса Route)
  Может перемещаться между станциями, указанными в маршруте.
  Показывать предыдущую станцию, текущую, следующую, на основе маршрута
=end

require_relative 'producer'
require_relative 'string_generator'

class Train
  include Producer
  include StringGenerator
  include Validation

  attr_reader :type
  attr_accessor :speed, :wagons, :number

  validate :speed, :presence
  validate :number, :presence
  validate :speed, :type, Integer
  validate :type, :type, String

  #NUMBER_FORMAT = /^([a-z]|[1-9]){3}(-)?([a-z]|[1-9]){2}$/i.freeze

  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
    @@trains[number] = self
    @wagons = []
    #validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def iterate_wagons(&block)
    wagons.each { |wagon| block.call(wagon) } if block_given?
  end

  def uncouple_wagon
    wagons.pop if conditions?
    puts "Wagon uncoupled and #{wagons_size} left"
  end

  def move_to_rote(route)
    return 'Stop train and add wagons' unless conditions?

    puts "Route stations #{route.station_list}. #{number} starts from station #{route.stations.first.name}"
    pass_route(route)
  end

  def speed_zero?
    speed.zero?
  end

  def wagons_any?
    wagons.any?
  end

  def wagons_size
    wagons.size
  end

  def conditions?
    speed_zero? && wagons_any?
  end

  #def valid?
  #  validate!
  #rescue StandardError
  #  false
  #end

  def train_info
    { number: number, type: type, wagon_size: wagons.size }
  end

  protected

  def pass_route(route)
    route.stations.each do |station|
      speed_up
      stop
      puts "#{number} arrives to station #{station.name}"
      station.get_train(number, self)
      return_station_info_message(station)
      station.send_train(number)
      return_movement_message(route, station)
    end
  end

  def stop
    while speed.positive?
      self.speed -= speed_change
      self.speed = 0 if speed.negative?
      show_speed
    end
  end

  def speed_change
    10
  end

  def speed_up
    self.speed += 10
    show_speed
  end

  def show_speed
    puts "Speed is #{self.speed}"
  end

  #def validate!
  #  raise 'Number length should be unless 5 symbols' if number.to_s.length < 5
  #  raise 'Number should match the format (/^([a-z]|[1-9]){3}(-)?([a-z]|[1-9]){2}$/i)' if number !~ NUMBER_FORMAT
  #
  #  true
  #rescue StandardError => e
  #  error_message = e.message
  #  puts "Validation error: #{error_message}"
  #end

  def return_movement_message(route, station)
    if station == route.stations.last
      puts "#{number} arrives to last station #{station.name}"
    else
      puts "#{number} departures from station #{station.name}"
    end
  end

  def return_station_info_message(station)
    puts "Station #{station.name} info: #{
      station.iterate_trains do |number, value|
        station.train_list[number].train_info

        value.iterate_wagons(&:wagon_info)
      end
    }"
  end
end
