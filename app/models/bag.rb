class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable

  scope :trims,   -> { joins(:lots).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lots).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lots).merge(Lot.where(category: category)) }

  

  belongs_to :container

  has_many :jars

  has_many :plants, through: :container

  has_many :strains, through: :container

  

  delegate :category, to: :container, prefix: false, allow_nil: true



  has_many :lots, through: :container

  
  
  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    alias_method :real_strains, :strains
    alias_method :real_category, :category

  public

    def lot
      lots.first
    rescue
      ''
    end

    def strain
      lots.map(&:strains).uniq.first
    rescue
      ''
    end


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
