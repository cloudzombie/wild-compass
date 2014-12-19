class Plant < ActiveRecord::Base

  ##########################
  ### Plant              ###
  ##########################
  ### cultivar: Cultivar ###
  ### format:   Format   ###
  ### status:   Status   ###
  ### rfid:     Rfid     ###
  ### lot:      Lot      ###
  ##########################
  


  ### History

  belongs_to :history

  belongs_to :cultivar

  belongs_to :format

  belongs_to :status

  belongs_to :rfid

  belongs_to :lot
  
  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end