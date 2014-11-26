class Lot < ActiveRecord::Base

  #####################
  ### Lot           ###
  #####################
  ### plants: Plant ###
  ### bags:   Bag   ###
  #####################



  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags
end
