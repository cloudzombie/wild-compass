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

  delegate :origin, to: :lot, prefix: false, allow_nil: true
  
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
