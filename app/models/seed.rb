class Seed < ActiveRecord::Base

  has_many :plants

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

end
