class Student < ActiveRecord::Base
  validates_presence_of :name, :lastname, :birthdate
end
