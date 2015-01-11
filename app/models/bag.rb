class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:container).merge(Container.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:container).merge(Container.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:container).merge(Container.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:container).merge(Container.where(category: category)) }

  ### Container

  belongs_to :container

  ### Jars

  has_many :jars

  ### Plants

  has_many :plants, through: :lot

  has_one :strain, through: :lot

  has_one :category, through: :lot
  
  ### Lot

  has_one :lot, through: :container
  
  def to_s
    "#{ name.upcase unless name.nil? }"
  end

end
