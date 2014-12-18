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



  ### Weight

  validates :weight, presence: true, numericality: { greater_than: 0 }



  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
