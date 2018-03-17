class TownSerializer < ActiveModel::Serializer
  attributes :name, :zipcode, :latitude, :longitude, :forecast
end
