class Container < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { where(category: category).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { Container.joins(:strains).merge(Strain.where(brand: brand)).uniq }



  has_and_belongs_to_many :plants, -> { uniq }

  accepts_nested_attributes_for :plants

  has_and_belongs_to_many :lots, -> { uniq }

  has_many :bags

  has_many :jars, through: :bags

  has_many :strains, -> { uniq }, through: :plants

  has_many :brands, -> { uniq }, through: :strains

  belongs_to :location

  def to_s
    "#{ name.try(:upcase) }"
  rescue
    ''
  end

  def plant
    plants.first
  rescue
    ''
  end

  def bag
    bags.first
  rescue
    ''
  end

  def jar
    jars.first
  rescue
    ''
  end

  def strain
    strains.first
  rescue
    ''
  end

  def lot
    lots.first
  rescue
    ''
  end

end
