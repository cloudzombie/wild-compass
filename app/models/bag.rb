class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable
  

  scope :by_strains,       -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories,    -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,         -> { by_categories 'Trim' }
  scope :by_buds,          -> { by_categories 'Buds' }
  scope :by_brands,        -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  def self.first_available(brand, weight)
    by_brands(brand).where(current_weight: weight..Float::INFINITY).first
  end

  belongs_to :lot

  has_many :jars, -> { uniq }

  has_many :plants, through: :lot

  belongs_to :container

  has_many :strains, -> { uniq }, through: :plants

  belongs_to :bin

  delegate :category, to: :container, prefix: false, allow_nil: true

  has_one :location, through: :bin
  
  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  def location
    bag.bin.location
  end

  def strain
    strains.first
  rescue
    ''
  end

  def jar
    jars.first
  rescue
    ''
  end

  def plant
    plants.first
  rescue
    ''
  end

  def category
    container.category
  rescue
    ''
  end

end
