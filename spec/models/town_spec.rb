require 'rails_helper'

RSpec.describe Town, type: :model do
  describe 'Geocoding' do
    it 'validation does geocoding' do
      belfort      = Town.new
      belfort.name = 'belfort'
      belfort.save

      expect(belfort.latitude).to eq(47.6379599)
      expect(belfort.longitude).to eq(6.8628942)
    end

    it 'does not exist' do
      unknown      = Town.new
      unknown.name = 'Town that does not exist'

      expect { unknown.save }.to raise_error(ArgumentError)
    end
  end
end
