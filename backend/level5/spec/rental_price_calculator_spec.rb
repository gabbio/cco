require 'rental_price_calculator'

describe RentalPriceCalculator do
  let(:rented_car) {
    { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
  }
  
  let(:one_day_rental) {
    { "id" => 1, "car_id" => 1, "start_date" => "2015-12-8", "end_date" => "2015-12-8", "distance" => 100 }
  }
  
  let(:two_days_rental) {
    { "id" => 2, "car_id" => 1, "start_date" => "2015-03-31", "end_date" => "2015-04-01", "distance" => 300 }
  }
  
  let(:twelve_days_rental) {
    { "id" => 3, "car_id" => 1, "start_date" => "2015-07-3", "end_date" => "2015-07-14", "distance" => 1000 }
  }

  let(:one_day_rpc) { described_class.new(one_day_rental, rented_car) }

  let(:two_days_rpc) { described_class.new(two_days_rental, rented_car) }

  let(:twelve_days_rpc) { described_class.new(twelve_days_rental, rented_car) }

  describe '#duration' do
    it 'given rental of 1 day' do
      expect(one_day_rpc.duration).to eq(1)
    end

    it 'given rental of 2 days' do
      expect(two_days_rpc.duration).to eq(2)
    end

    it 'given rental of 12 days' do
      expect(twelve_days_rpc.duration).to eq(12)
    end
  end

  describe '#duration_price' do
    it 'given rental of 1 day' do
      expect(one_day_rpc.duration_price).to eq(2000)
    end

    it 'given rental of 2 days' do
      expect(two_days_rpc.duration_price).to eq(3800)
    end

    it 'given rental of 12 days' do
      expect(twelve_days_rpc.duration_price).to eq(17800)
    end
  end

  describe '#distance_price' do
    it 'given rental of 100 km' do
      expect(one_day_rpc.distance_price).to eq(1000)
    end

    it 'given rental of 300 km' do
      expect(two_days_rpc.distance_price).to eq(3000)
    end

    it 'given rental of 1000 km' do
      expect(twelve_days_rpc.distance_price).to eq(10000)
    end
  end

  describe '#duration_discount' do
    it 'given rental of 1 day' do
      expect(one_day_rpc.duration_discount).to eq(0)
    end

    it 'given rental of 2 days' do
      expect(two_days_rpc.duration_discount).to eq(200)
    end

    it 'given rental of 12 days' do
      expect(twelve_days_rpc.duration_discount).to eq(6200)
    end
  end

  describe '#rental_price' do
    it 'given rental of 1 day and 100 km' do
      expect(one_day_rpc.rental_price).to eq(3000)
    end

    it 'given rental of 2 days and 300 km' do
      expect(two_days_rpc.rental_price).to eq(6800)
    end

    it 'given rental of 12 days and 1000 km' do
      expect(twelve_days_rpc.rental_price).to eq(27800)
    end
  end
end