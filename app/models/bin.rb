class Bin < ActiveRecord::Base

  include Encodable
  include Sortable
  include Searchable

  scope :by_brands,   -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)) }

  scope :fulfilled,   -> { uniq.joins(:jars).merge( Jar.fulfilled   )}
  scope :unfulfilled, -> { uniq.joins(:jars).merge( Jar.unfulfilled )}

  has_many :strains,  -> { uniq }, through: :plants

  has_many :plants,   -> { uniq}, through: :bags

  has_many :bags,     -> { uniq }

  has_many :jars,     -> { uniq }, through: :bags

  belongs_to :location
  

  def available?
    true
  end

  def to_s
    "BIN-#{id}"
  end
end
