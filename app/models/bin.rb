class Bin < ActiveRecord::Base

  include Encodable

  has_many :bags

  belongs_to :location
  

  def available?
    true
  end

  def to_s
    "BIN_#{id}"
  end
end
