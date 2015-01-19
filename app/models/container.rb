class Container < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories, -> (category = nil) { joins(:lots).merge(Lot.where(category: category)) }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  



  has_and_belongs_to_many :plants

  accepts_nested_attributes_for :plants

	has_and_belongs_to_many :lots

  has_many :bags, through: :lots

  has_many :jars, through: :lots



  has_many :strains, through: :plants



  def to_s
    "#{ name.try(:upcase) }"
  rescue
    ''
  end



  def category
    lots.map(&:category).uniq.first
  rescue
    ''
  end

  def lot
    lots.first
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
