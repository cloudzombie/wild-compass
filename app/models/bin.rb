class Bin < ActiveRecord::Base

  include Encodable

  scope :fulfilled,   -> { uniq.joins(:jars).merge( Jar.fulfilled   )}
  scope :unfulfilled, -> { uniq.joins(:jars).merge( Jar.unfulfilled )}

  has_many :bags, -> { uniq }

  has_many :jars, -> { uniq }, through: :bags

  belongs_to :location
  

  def available?
    true
  end

  def to_s
    "BIN-#{id}"
  end
end
