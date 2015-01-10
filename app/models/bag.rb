class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:lot).merge(Lot.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }



  ### Lot

  belongs_to :lot



  ### Jars

  has_many :jars



  ### Plants

  has_many :plants, through: :lot

  has_one :strain, through: :lot

  has_one :category, through: :lot
  


  def to_s
    "#{ name.upcase unless name.nil? }"
  end

end
