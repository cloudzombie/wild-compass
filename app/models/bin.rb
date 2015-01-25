class Bin < ActiveRecord::Base

  has_many :bags

  def available?
    true
  end

  def to_s
    "BIN_#{id}"
  end
end
