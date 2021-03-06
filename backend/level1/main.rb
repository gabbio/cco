require 'json'
require 'date'

data = File.read('data/input.json')

parsed_data = JSON.parse(data)

parsed_data["rentals"].map! do |rental|
  rented_car = parsed_data["cars"].select { |car| car["id"] == rental["car_id"] }.first
  rental_duration = (Date.parse(rental["end_date"]) - Date.parse(rental["start_date"])).to_i + 1

  rental_price = (rental_duration * rented_car["price_per_day"]) + (rental["distance"] * rented_car["price_per_km"])

  # From rental data as expected
  { id: rental["id"], price: rental_price }
end

parsed_data.delete("cars")

File.write('data/output.json', JSON.dump(parsed_data))