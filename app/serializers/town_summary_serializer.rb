class TownSummarySerializer < ActiveModel::Serializer
  attributes :id, :name, :zipcode, :latitude, :longitude
end
