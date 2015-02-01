class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable



  attr_accessor :scanned_hash
  


  scope :by_strains,       -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories,    -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,         -> { by_categories 'Trim' }
  scope :by_buds,          -> { by_categories 'Buds' }
  scope :by_brands,        -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  

  def self.first_available(brand, weight)
    by_brands(brand).where(current_weight: weight..Float::INFINITY, tested: false, archived: false).first
  end



  belongs_to :lot

  belongs_to :container

  belongs_to :bin



  has_many :jars, -> { uniq }

  has_many :plants, through: :lot

  has_many :strains, -> { uniq }, through: :plants

  

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
