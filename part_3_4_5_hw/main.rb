require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'

OPTIONS = { 1 => 'Give name to station',
            2 => 'Create route',
            3 => 'Create Train',
            4 => 'Hitch wagon',
            5 => 'Uncouple wagon',
            6 => 'Put train to route',
            7 => 'Exit'}.freeze
loop do
  puts "Options list #{OPTIONS}"
  option = gets.chomp.to_i
  case option
  when 1
    puts 'Give name to station1'
    name1 = gets.chomp
    @station1 = Station.new name1
    puts 'Give name to station2'
    name2 = gets.chomp
    @station2 = Station.new name2
  when 2
    if @station1.nil? && @station2.nil?
      puts 'Create station first'
    else
      @route = Route.new(@station1, @station2)
      puts "Route created #{@route}"
      p @route
    end
  when 3
    puts 'Give it a type: dial 0 - for PassengerTrain or 1 - for CargoTrain'
    types = %w[PassengerTrain CargoTrain]
    train_type = types[gets.chomp.to_i]
    train_number = Time.now.to_s
    @train = (Object.const_get train_type).new(train_number)
    p @train
  when 4
    puts 'Put a number as an amount of wagons to hitch'
    wagons_amount = gets.chomp.to_i
    wagons_amount.times { @train.hitch_wagon }
  when 5
    @train.uncouple_wagon
    p @train
  when 6
    return 'Create train first' unless @train

    @train.move_to_rote(@route)
    p @train
  when 7
    break
  else
    puts 'Choose correct option key'
  end
end
