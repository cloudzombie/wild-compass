class Container < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }



	belongs_to :lot

  has_many :strains, through: :lot



  ### We need to use delegate, category is not a model...

  delegate :category, to: :lot, prefix: false, allow_nil: true

  # has_one :category, through: :lot

	

  has_many :plants, through: :lot

  has_many :bags

  has_many :jars, through: :bags	



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    alias_method :real_strains, :strains
    alias_method :real_category, :category

  public

    def strains
      self.real_strains
    rescue
      ''
    end

    def category
      self.real_category
    rescue
      ''
    end

end
