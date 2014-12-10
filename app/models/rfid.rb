class Rfid < ActiveRecord::Base
  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end