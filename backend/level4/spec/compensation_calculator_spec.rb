require 'compensation_calculator'

describe CompensationCalculator do
  let(:rented_car) {
    { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
  }
  
  let(:rental) {
    { "id" => 3, "car_id" => 1, "start_date" => "2015-07-3", "end_date" => "2015-07-14", "distance" => 1000 }
  }

  let(:rpc) { RentalPriceCalculator.new(rental, rented_car) }
  let(:commission) { CommissionCalculator.new(rpc) }
  let(:compensation) { CompensationCalculator.new(rpc, commission) }

  describe '#format_actions' do
    it 'have list of beneficiaries' do
      expect(described_class::BENEFICIARIES).to be_instance_of(Array)
      expect(described_class::BENEFICIARIES).not_to be_empty
    end

    it 'given rental and commission returns an array' do
      expect(compensation.format_actions).to be_instance_of(Array)
      expect(compensation.format_actions).not_to be_empty
    end

    it 'given rental and commission returns action for all the actors' do
      expect(compensation.format_actions.length).to eq(5)
    end
  end
end