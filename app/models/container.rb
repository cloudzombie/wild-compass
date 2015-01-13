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

  has_one :category, through: :lot

	has_many :plants, through: :lot

  has_many :bags

  has_many :jars, through: :bags	

	has_one :strain, through: :lot



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    alias_method :real_strain, :strain
    alias_method :real_category, :category

  public

    def strain
      self.real_strain
    rescue
      ''
    end

    def category
      self.real_category
    rescue
      ''
    end

end
