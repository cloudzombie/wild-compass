class Bag < ActiveRecord::Base

  #####################
  ### Bag           ###
  #####################
  ### lot:    Lot   ###
  ### pots:   Pot   ###
  ### plants: Plant ###
  #####################



  ### Lot

  belongs_to :lot



  ### Pots

  has_many :pots



  ### Plants

  has_many :plants, through: :lot
end
