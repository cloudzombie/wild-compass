class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  ### Strain

  belongs_to :strain



  ### Format

  belongs_to :format



  ### Status

  belongs_to :status



  ### RFID

  belongs_to :rfid


  ### Lot

  belongs_to :lot



  ### Utils
  
  def to_s
    "#{ name.titleize unless name.nil? }"
  end

end