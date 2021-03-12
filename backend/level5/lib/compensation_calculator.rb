require_relative 'options'

class CompensationCalculator
  DEBIT_ACTION = 'debit'
  CREDIT_ACTION = 'credit'

  BENEFICIARIES = [
    {
      who: "driver",
      type: "debit",
    },
    {
      who: "owner",
      type: "credit",
    },
    {
      who: "insurance",
      type: "credit",
    },
    {
      who: "assistance",
      type: "credit",
    },
    {
      who: "drivy",
      type: "credit",
    }
  ]

  def initialize(rental, commission, options = [])
    @rental = rental
    @commission = commission
    @options = options
  end

  def option_price
    @option_price ||= @options.inject(0) do |options_price, option|
      options_price + Options::get_price(option) * @rental.duration
    end
  end

  def format_actions
    @actions ||= BENEFICIARIES.map do |beneficiary|
      case beneficiary[:who]
      when 'driver'
        amount =  @rental.rental_price + option_price
      when 'owner'
        amount = @rental.rental_price - @commission.global_commission
        amount += Options::get_price('gps') * @rental.duration if @options.include?('gps')
        amount += Options::get_price('baby_seat') * @rental.duration if @options.include?('baby_seat')
      when 'insurance'
        amount = @commission.format_commission[:insurance_fee]
      when 'assistance'
        amount = @commission.format_commission[:assistance_fee]
      when 'drivy'
        amount = @commission.format_commission[:drivy_fee]
        amount += Options::get_price('additional_insurance') * @rental.duration if @options.include?('additional_insurance')
      end

      beneficiary.merge amount: amount
    end
  end
end