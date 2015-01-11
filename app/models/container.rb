class Container < ActiveRecord::Base

<<<<<<< HEAD
	has_many :bags

	belongs_to :lot

=======
  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:lot).merge(Lot.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }



	belongs_to :lot

	has_many :bags

	has_many :plants

	has_one :strain, through: :lot



  def to_s
    "#{ name.upcase unless name.nil? }"
  end
>>>>>>> c28d00f06842f7fdbad899deee6d794a17fdc542
end
