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


  
  ### Containers

  belongs_to :container

  has_many :containers



  ### Plants

  has_and_belongs_to_many :plants, -> { uniq }

  accepts_nested_attributes_for :plants

  def plant
    plants.first
  rescue
    ''
  end



  ### Lots

  has_and_belongs_to_many :lots, -> { uniq }

  def lot
    lots.first
  rescue
    ''
  end



  ### Bags

  has_many :bags

  def bag
    bags.first
  rescue
    ''
  end



  ### Jars

  has_many :jars, through: :bags

  def jar
    jars.first
  rescue
    ''
  end



  ### Strains

  has_many :strains, -> { uniq }, through: :plants

  def strain
    strains.first
  rescue
    ''
  end



  ### Brands

  has_many :brands,  -> { uniq }, through: :strains



  ### Locations

  belongs_to :location



  ### Utils

  def to_s
    "#{ name.try(:upcase).sub('CONTAINER','CTN') }"
  rescue
    ''
  end  

end
