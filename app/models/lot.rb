class Lot < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :strains, -> (strain = nil) { where(strain: strain) }
  scope :categories, -> (category = nil) { where(category: category) }
  scope :trims,   -> { where(category: 'Trim') }
  scope :buds,    -> { where(category: 'Buds') }



  belongs_to :strain


  
  has_many :plants

  has_many :containers
  
  has_many :bags, through: :containers

  has_many :jars, through: :containers



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

end
