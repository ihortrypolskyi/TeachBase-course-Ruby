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

  attr_reader :number
  attr_reader :speed
  attr_accessor :wagons
  attr_reader :type

  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
    @@trains[number] = self
    @wagons = []
  end

  def self.find(number)
    @@trains[number]
  end

  def uncouple_wagon
    wagons.pop if conditions?
    puts "Wagon uncoupled and #{wagons_size} left"
  end

  def move_to_rote(route)
    return puts 'Add wagons or stop train' unless conditions?

    puts "Route stations #{route.station_list}"
    puts "starts from station #{route.stations.first.name}"

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

  protected

  attr_writer :speed

  def average_speed
    10
  end

  def pass_route(route)
    route.stations.each do |s|
      speed_up
      slow_down
      puts "arrived to station #{s.name}"
      s.get_train(number, type)
      p s.train_list_by_type(type)
      s.send_train(number)
      p s.train_list_by_type(type)
      s == route.stations.last ? (puts "arrived to last station #{s.name} #{slow_down}") : (puts "departure from station #{s.name}")
    end
  end

  def slow_down
    self.speed = 0
    puts "Speed is #{speed}"
  end

  def speed_up
    self.speed = average_speed
    puts "Speed is #{average_speed}"
  end
end
