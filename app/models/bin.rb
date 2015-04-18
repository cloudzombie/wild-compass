class Bin < ActiveRecord::Base

  include Encodable
  include Sortable
  include Searchable

  scope :by_brands,   -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)) }

  scope :fulfilled,   -> { joins(:outgoing_jars).merge( Jar.fulfilled   )}
  scope :unfulfilled, -> { joins(:outgoing_jars).merge( Jar.unfulfilled )}

  has_many :strains,  -> { uniq }, through: :plants

  has_many :plants,   -> { uniq}, through: :lots

  has_many :lots,     -> { uniq }, through: :bags

  has_many :bags

  has_many :outgoing_jars, through: :bags


  def jars
    outgoing_jars
  end

  belongs_to :location

  def available?
    true
  end

  def to_s
    "BIN-#{id}"
  end
end
