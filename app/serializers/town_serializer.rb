class TownSerializer < ActiveModel::Serializer
  attributes :id, :name, :zipcode, :latitude, :longitude, :forecast
end
