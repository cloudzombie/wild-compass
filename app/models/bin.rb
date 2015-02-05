class Bin < ActiveRecord::Base

  include Encodable

  scope :fulfilled,   -> { joins(:jars).merge(Jar.fulfilled) }
  scope :unfulfilled, -> { joins(:jars).merge(Jar.unfulfilled) }

  has_many :bags

  has_many :jars, -> { uniq }, through: :bags

  belongs_to :location
  

  def available?
    true
  end

  def to_s
    "BIN-#{id}"
  end
end
