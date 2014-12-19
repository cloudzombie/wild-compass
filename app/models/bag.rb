class Bag < ActiveRecord::Base

  #######################
  ### Bag             ###
  #######################
  ### lot:    Lot     ###
  ### jars:   Jar[]   ###
  ### plants: Plant[] ###
  ### weight: int     ###
  #######################

  

  ### History

  belongs_to :history



  ### Lot

  belongs_to :lot



  ### Jars

  has_many :jars



  ### Plants

  has_many :plants, through: :lot

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
