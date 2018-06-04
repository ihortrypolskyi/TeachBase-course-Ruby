=begin
  Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может показывать список всех поездов на станции, находящиеся в текущий момент
  Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :train_list, :name

  @@stations = []

  def initialize(name)
    @name = name
    @train_list = {}
    @@stations << self
  end

  def self.all
    @@stations
  end

  def get_train(train_number, train)
    @train_list[train_number] = train
  end

  def send_train(train_number)
    @train_list.delete(train_number)
  end

  def train_list_by_type(type)
    @train_list.map { |k, v| k if v == type }
  end

  def iterate_trains(&block)
    train_list.each { |number, value| block.call(number, value) } if block_given?
  end
end
