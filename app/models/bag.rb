class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:lot).merge(Lot.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }

  

  belongs_to :container

  has_many :jars

  has_many :plants, through: :container

  has_one :strain, through: :container

  has_one :category, through: :container

  has_one :lot, through: :container


  
  def to_s
    "#{ name.upcase unless name.nil? }"
  end

end
