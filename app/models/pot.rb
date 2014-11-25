class Pot < ActiveRecord::Base

  #####################
  ### Pot           ###
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
end