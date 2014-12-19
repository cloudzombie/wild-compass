class Jar < ActiveRecord::Base

  ###############################
  ### Jar                     ###
  ###############################
  ### history: History        ###
  ### bag:     Bag            ###
  ### plants:  Plant          ###
  ### lot:     Lot            ###
  ### initial_weight: integer ###
  ### current_weight: integer ###
  ###############################



  ### History

  belongs_to :history



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



  ### Utils

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

end