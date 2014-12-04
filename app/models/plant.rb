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

  belongs_to :cultivar

  belongs_to :format

  belongs_to :status

  belongs_to :rfid

  belongs_to :lot
end