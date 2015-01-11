class Lot < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :strains, -> (strain = nil) { where(strain: strain) }
  scope :categories, -> (category = nil) { where(category: category) }
  scope :trims,   -> { where(category: 'Trim') }
  scope :buds,    -> { where(category: 'Buds') }



  ### Strain

  belongs_to :strain



  ### Plants

  has_many :plants

  ### Containers

  has_many :containers

  ### Bags
  
  has_many :bags

  ### Jar

  has_many :jars, through: :bag



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

end
