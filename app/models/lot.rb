class Lot < ActiveRecord::Base

  #####################
  ### Lot           ###
  #####################
  ### plants: Plant ###
  ### bags:   Bag   ###
  ### weight: int   ###
  #####################



  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags



  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
