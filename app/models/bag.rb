class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)) }
  scope :by_trims,      -> { by_categories 'Trim' }
  scope :by_buds,       -> { by_categories 'Buds' }
  

  

  belongs_to :lot

  has_many :jars

  has_many :plants, through: :lot

  has_many :containers, through: :lot

  has_many :strains, through: :plants

  delegate :category, to: :container, prefix: false, allow_nil: true



  
  
  def to_s
    "#{ name.upcase unless name.nil? }"
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

  def container
    containers.first
  rescue
    ''
  end

end
