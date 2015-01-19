class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories, -> (category = nil) { joins(:lots).merge(Lot.where(category: category)) }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }



  ### Bag

  belongs_to :bag

  validates :bag, presence: true



  ### Order_line

  belongs_to :order_line



  ### Plants

  has_many :plants, through: :bag
  
  

  ### Lot

  has_many :lots, through: :bag

  has_many :strains, through: :plants

  delegate :category, to: :bag, prefix: false, allow_nil: true



  ### Datamatrix

  def datamatrix
    Datamatrix.new(id)
  end



  ### Utils

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