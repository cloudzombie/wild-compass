class Lot < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)) }
  scope :by_trims,      -> { by_categories 'Trim' }
  scope :by_buds,       -> { by_categories 'Buds' }

  

  has_many :strains, through: :plants

  has_and_belongs_to_many :containers

  accepts_nested_attributes_for :containers

  has_many :plants, through: :containers
  
  has_many :bags

  has_many :jars, through: :bags

  delegate :category, to: :container, prefix: false, allow_nil: true



  def to_s
    "#{ name.upcase unless name.nil? }"
  end



  def container
    containers.first
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

end
