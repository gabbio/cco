class CommissionCalculator
  RATE = 0.3
  INSURANCE_RATE = 0.5
  ASSISTANCE_RATE = 100

  def initialize(rental)
    @rental = rental
  end

  def global_commission
    @commission ||= (@rental.rental_price * RATE).to_i
  end

  def insurance_fee
    @insurance_fee ||= (global_commission * INSURANCE_RATE).to_i
  end

  def assistance_fee
    @assistance_fee ||= @rental.duration * ASSISTANCE_RATE
  end

  def drivy_fee
    @drivy_fee ||= (global_commission - (insurance_fee + assistance_fee)).to_i
  end

  def format_commission
    {
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    }
  end
end