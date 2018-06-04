# frozen_string_literal: true

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
            5 => 'Load wagon or let one passenger in',
            6 => 'Uncouple wagon',
            7 => 'Get train info',
            8 => 'Put train to route',
            9 => 'Exit' }.freeze
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
      puts 'Route created'
      p @route
    end
  when 3
    next unless @train.nil?

    puts 'Select a type for train : dial 0 - for PassengerTrain or 1 - for CargoTrain'
    types = %w[PassengerTrain CargoTrain]
    train_type = types[gets.chomp.to_i]

    loop do
      puts 'Assign a number to train'
      train_number = gets.chomp
      @train = (Object.const_get train_type).new(train_number)

      @train.valid? ? break : @train = nil
    end

    puts 'Train is created'
    p @train
  when 4
    puts 'Put a number of wagons to hitch'
    wagons_amount = gets.chomp.to_i

    case @train.type
    when :passenger
      puts 'Put a number of sits'
    when :cargo
      puts 'Put available value to load'
    end

    hitch_attribute = gets.chomp.to_i

    wagons_amount.times { @train.hitch_wagon(hitch_attribute) }
    puts "#{wagons_amount} wagons hitched"
    p @train
  when 5
    if @train.nil? || !@train.wagons_any?
      puts 'Create train with wagons first'
    else
      loop do
        puts "Where are #{@train.wagons_size} for current train. Put a wagon number to select"
        @wagon_number = gets.chomp.to_i

        break if @wagon_number.positive? && @train.wagons_size >= @wagon_number

        puts "Please, put number between 0 and #{@train.wagons_size}"
      end
      case @train.type
      when :passenger
        @train.wagons[@wagon_number].occupy_a_sit
      when :cargo
        puts 'Put value to load'
        value_to_load = gets.chomp.to_i
        p @wagon_number
        p @train.wagons
        p @train.wagons[@wagon_number]
        @train.wagons[(@wagon_number - 1)].load_value(value_to_load)
      end
    end
  when 6
    @train.uncouple_wagon
    puts 'One wagon uncoupled'
    p @train
  when 7
    if @train.nil?
      puts 'Create train first'
    else
      puts "Train info #{@train.train_info}"
      puts "Train wagons info #{@train.iterate_wagons(&:wagon_info)}"
    end
  when 8
    if @train.nil?
      puts 'Create train first'
    else
      @train.move_to_rote(@route)
      p @train
    end
  when 9
    break
  else
    puts 'Choose correct option key'
  end
end
