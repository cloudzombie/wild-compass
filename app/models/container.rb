class Container < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lots).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lots).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lots).merge(Lot.where(category: category)) }



	has_and_belongs_to_many :lots

  has_many :strains, through: :lots

  has_many :plants, through: :lots



  has_many :bags

  has_many :jars, through: :bags	



  def to_s
    name.upcase
  rescue
    ''
  end



  def category
    lots.map(&:category).uniq
  rescue
    ''
  end



  private

    alias_method :real_strains, :strains

  public

    def strains
      self.real_strains
    rescue
      ''
    end

end
