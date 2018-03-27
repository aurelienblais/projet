class Town < ActiveRecord::Base
  MAX_RECORD = ENV.fetch('MAX_TOWN_RECORD', 20)

  before_save :get_geocoding
  before_save :max_rows?
  validates_presence_of :name
  validates_uniqueness_of :name

  def forecast
    redis = RedisService.new
    return forecast ||= JSON.parse(redis.get(key)) if redis.exists(key)
    forecast ||= JSON.parse(redis.set(key, ForecastIO.forecast(latitude, longitude, params: { units: 'si', lang: 'fr' }).currently.to_json))
  rescue StandardError
    nil
  end

  private

  def key
    require 'digest'
    Digest::SHA256.hexdigest(id.to_s + name)
  end

  def get_geocoding
    town = Nominatim.search.city(name).country('France').limit(1).address_details(true).first
    raise ArgumentError, 'Unknown town' if town.nil?

    self.zipcode   = town.address.postcode
    self.latitude  = town.latitude
    self.longitude = town.longitude
  end

  # Nasty method used to avoid mass town creation
  def max_rows?
    if Town.all.count > MAX_RECORD
      errors.add(:error, "Too many records (max: #{MAX_RECORD})")
      false
    else
      true
    end
  end
end
