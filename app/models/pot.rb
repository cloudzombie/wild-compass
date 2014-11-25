class Pot < ActiveRecord::Base

  #####################
  ### Pot           ###
  #####################
  ### bag:    Bag   ###
  ### plants: Plant ###
  ### lot:    Lot   ###
  #####################

  belongs_to :bag

  has_many :plants, through: :bag

  def lot
    bag.lot
  end

  def lot=(lot)
    bag.lot = lot
  end
end
