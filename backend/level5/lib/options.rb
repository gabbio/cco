module Options
  PRICE_BY_OPTION = {
    gps: 500,
    baby_seat: 200,
    additional_insurance: 1000
  }.freeze

  class << self
    def get_price(option_name)
      PRICE_BY_OPTION[option_name.to_sym]
    end
  end
end