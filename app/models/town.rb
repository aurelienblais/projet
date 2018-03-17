class Town < ActiveRecord::Base
  before_save :get_geocoding
  validates_presence_of :name


  private

  def get_geocoding
    town = Nominatim.search.city(name).country('France').limit(1).address_details(true).first
    raise ArgumentError.new('Unknown town') if town.nil?

    self.zipcode   = town.address.postcode
    self.latitude  = town.latitude
    self.longitude = town.longitude
  end
end
