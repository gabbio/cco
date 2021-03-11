require 'date'

class RentalPriceCalculator

  DISCOUNT_STEPS = {
    2 => 0.1,
    5 => 0.3,
    11 => 0.5,
  }.freeze

  def initialize(rental, car)
    @rental = rental
    @car = car
  end

  def rental_price
    duration_price + distance_price
  end

  def distance_price
    @car["price_per_km"] * @rental["distance"]
  end

  def duration_price
    @car["price_per_day"] * duration - duration_discount
  end

  def duration_discount
    remaining_duration = duration
    
    DISCOUNT_STEPS.keys.reverse.inject(0) do |reduction, threshold|
      if remaining_duration >= threshold
        days_concerned = remaining_duration - (threshold - 1)
        remaining_duration = remaining_duration - days_concerned
        reduction += days_concerned * @car["price_per_day"] * DISCOUNT_STEPS[threshold]
      end
      reduction
    end.to_i
  end

  def duration
    @rental_duration ||= (Date.parse(@rental["end_date"]) - Date.parse(@rental["start_date"])).to_i + 1
  end
end