class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }

  

  belongs_to :container

  has_many :jars

  has_many :plants, through: :container

  has_many :strains, through: :container

  

  ### We need to use delegate, category is not a model...

  delegate :category, to: :container, prefix: false, allow_nil: true

  # has_one :category, through: :container



  has_one :lot, through: :container

  delegate :origin, to: :lot, prefix: false, allow_nil: true
  
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
