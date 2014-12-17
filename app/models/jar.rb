class Jar < ActiveRecord::Base

  #####################
  ### Jar           ###
  #####################
  ### bag:    Bag   ###
  ### plants: Plant ###
  ### lot:    Lot   ###
  #####################



  ### Bag

  belongs_to :bag



  ### Plants

  has_many :plants, through: :bag



  ### Lot

  def lot
    bag.lot
  end

  def lot=(lot)
    bag.lot = lot
  end

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end