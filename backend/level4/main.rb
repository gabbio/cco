require 'pry'
require 'json'
require 'date'
require_relative 'lib/rental_price_calculator.rb'
require_relative 'lib/commission_calculator.rb'
require_relative 'lib/compensation_calculator.rb'

data = File.read('data/input.json')

parsed_data = JSON.parse(data)

parsed_data["rentals"].map! do |rental|
  rented_car = parsed_data["cars"].select { |car| car["id"] == rental["car_id"] }.first
  
  rpc = RentalPriceCalculator.new(rental, rented_car)

  commission = CommissionCalculator.new(rpc)

  compensation = CompensationCalculator.new(rpc, commission)

  { id: rental["id"], actions: compensation.format_actions }
end

parsed_data.delete("cars")

File.write('data/output.json', JSON.dump(parsed_data))