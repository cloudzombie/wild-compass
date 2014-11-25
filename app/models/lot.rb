class Lot < ActiveRecord::Base
  has_many :plants
  has_many :bags
end
