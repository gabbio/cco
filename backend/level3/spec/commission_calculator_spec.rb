require 'commission_calculator'

describe CommissionCalculator do
  let(:rented_car) {
    { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
  }
  
  let(:rental) {
    { "id" => 3, "car_id" => 1, "start_date" => "2015-07-3", "end_date" => "2015-07-14", "distance" => 1000 }
  }

  let(:rpc) { RentalPriceCalculator.new(rental, rented_car) }
  let(:commission) { described_class.new(rpc) }

  describe '#global_commission' do
    it 'given rental price returns global commission based on rate' do
      expect(commission.global_commission).to eq(8340)
    end
  end

  describe '#insurance_fee' do
    it 'given rental price returns insurance fee based on commission' do
      expect(commission.insurance_fee).to eq(4170)
    end
  end

  describe '#assistance_fee' do
    it 'given rental price returns assistance fee based on commission' do
      expect(commission.assistance_fee).to eq(1200)
    end
  end

  describe '#drivy_fee' do
    it 'given rental price returns drivy fee based on commission' do
      expect(commission.drivy_fee).to eq(2970)
    end
  end

  describe '#format' do
    context 'given rental price' do
      it 'formats with all the beneficiaries fees' do
        expect(commission.format_commission).to be_instance_of(Hash)
        expect(commission.format_commission).to have_key(:insurance_fee)
        expect(commission.format_commission).to have_key(:assistance_fee)
        expect(commission.format_commission).to have_key(:drivy_fee)
      end

      it 'returns the right insurance fees' do
        expect(commission.format_commission[:insurance_fee]).to eq(4170)
      end

      it 'returns the right assistance fees' do
        expect(commission.format_commission[:assistance_fee]).to eq(1200)
      end

      it 'returns the right drivy fees' do
        expect(commission.format_commission[:drivy_fee]).to eq(2970)
      end
    end
  end
end