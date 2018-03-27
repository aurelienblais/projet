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
      expect(unknown.forecast).to eq(nil)
    end
  end

  describe 'Forecast' do
    # Can't know data without mock or vcr
    it 'return JSON' do
      belfort      = Town.new
      belfort.name = 'belfort'
      belfort.save

      parse_json = belfort.forecast
      expect(parse_json['summary']).to_not eq(nil)
    end
  end

  describe 'Redis' do
    before :each do
      REDIS_POOL.with do |connection|
        connection.keys.each { |k| connection.del k }
      end
    end

    describe 'Redis up' do
      it 'set cache' do
        belfort      = Town.new
        belfort.name = 'belfort'
        belfort.save

        belfort_key = belfort.send(:key)

        redis = RedisService.new

        expect(redis.exists(belfort_key)).to eq(false)
        expect(redis.get(belfort_key)).to eq(nil)

        belfort.forecast

        expect(redis.exists(belfort_key)).to eq(true)
        expect(redis.get(belfort_key)).to_not eq(nil)
      end
    end

    describe 'Redis down' do
      it 'fail' do
        cached_redis_pool = REDIS_POOL
        REDIS_POOL        = ConnectionPool.new(size: 10, timeout: 5) { Redis.new(url: 'redis://localhost:22222/0') }

        belfort      = Town.new
        belfort.name = 'belfort'
        belfort.save

        belfort_key = belfort.send(:key)

        redis = RedisService.new

        expect(redis.exists(belfort_key)).to eq(false)
        expect(redis.get(belfort_key)).to eq(nil)

        belfort.forecast

        expect(redis.exists(belfort_key)).to eq(false)
        expect(redis.get(belfort_key)).to eq(nil)

        REDIS_POOL = cached_redis_pool
      end
    end
  end

  describe 'Max row' do
    it 'limit row number' do
      town_array     = %w[Lille Paris Caen Strasbourg Calais Marseille Toulon Nice Pecquencourt Arras Capinghem Exincourt Brest Trouville Troyes Compiegne Ronchin Lezennes Somain Orchies Fenain]
      current_number = Town.all.count
      max_record     = ENV.fetch('MAX_TOWN_RECORD', 20).to_i

      (0..(max_record - current_number)).each do |i|
        town = Town.create(name: town_array[i - 1])
        expect(town.id).not_to eq(nil)
      end

      expect(Town.create(name: 'Belfort').id).to eq(nil)
    end
  end
end
