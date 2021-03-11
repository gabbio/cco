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

  def initialize(rental, commission)
    @rental = rental
    @commission = commission
  end

  def format_actions
    @actions ||= BENEFICIARIES.map do |beneficiary|
      amount = case beneficiary[:who]
      when 'driver'
        @rental.rental_price
      when 'owner'
        @rental.rental_price - @commission.global_commission
      when 'insurance'
        @commission.format_commission[:insurance_fee]
      when 'assistance'
        @commission.format_commission[:assistance_fee]
      when 'drivy'
        @commission.format_commission[:drivy_fee]
      end

      beneficiary.merge amount: amount
    end
  end
end