class Lot < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :strains, -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :categories, -> (category = nil) { where(category: category) }
  scope :trims,   -> { where(category: 'Trim') }
  scope :buds,    -> { where(category: 'Buds') }



  has_many :plants

  has_many :strains, through: :plants
  
  


  has_many :containers
  
  has_many :bags, through: :containers

  has_many :jars, through: :containers



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    alias_method :real_strains, :strains

  public

    def strains
      self.real_strains
    end

end
