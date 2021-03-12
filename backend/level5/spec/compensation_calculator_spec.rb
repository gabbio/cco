require 'compensation_calculator'

describe CompensationCalculator do
  let(:rented_car) {
    { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
  }
  
  let(:one_day_rental) {
    { "id" => 1, "car_id" => 1, "start_date" => "2015-12-8", "end_date" => "2015-12-8", "distance" => 100 }
  }
  
  let(:two_days_rental) {
    { "id" => 2, "car_id" => 1, "start_date" => "2015-03-31", "end_date" => "2015-04-01", "distance" => 300 }
  }
  
  let(:one_day_options) { ["gps", "baby_seat"] }
  
  let(:two_days_options) { ["additional_insurance"] }

  let(:one_day_rpc) { RentalPriceCalculator.new(one_day_rental, rented_car) }
  let(:two_days_rpc) { RentalPriceCalculator.new(two_days_rental, rented_car) }
  let(:commission) { CommissionCalculator.new(one_day_rpc) }
  let(:one_day_compensation) { CompensationCalculator.new(one_day_rpc, commission, one_day_options) }
  let(:two_days_compensation) { CompensationCalculator.new(two_days_rpc, commission, two_days_options) }

  describe '#format_actions' do
    it 'have list of beneficiaries' do
      expect(described_class::BENEFICIARIES).to be_instance_of(Array)
      expect(described_class::BENEFICIARIES).not_to be_empty
    end

    it 'given rental and commission returns an array' do
      expect(one_day_compensation.format_actions).to be_instance_of(Array)
      expect(one_day_compensation.format_actions).not_to be_empty
    end

    it 'given rental and commission returns action for all the actors' do
      expect(one_day_compensation.format_actions.length).to eq(5)
    end
  end

  describe '#option_price' do
    it "given rental of 1 day with 1 option" do
      expect(one_day_compensation.option_price).to eq(700)
    end

    it "given rental of 2 days with 1 option" do
      expect(two_days_compensation.option_price).to eq(2000)
    end
  end
end