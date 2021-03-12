require 'options'

describe Options do
  describe '#get_price' do
    context 'given option name' do
      it 'returns option price' do
        expect(described_class.get_price('gps')).to eq(500)
        expect(described_class.get_price('baby_seat')).to eq(200)
        expect(described_class.get_price('additional_insurance')).to eq(1000)
      end
    end
  end
end