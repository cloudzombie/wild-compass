class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable
  include Sortable
  include Filterable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  scope :fulfilled,   -> { uniq.where fulfilled: true  } 
  scope :unfulfilled, -> { uniq.where fulfilled: false }



  def next
    jars = []
    order_line.jars.order(id: :asc).each do |jar|
      next if jar == self
      jars << jar if jar.unfulfilled?
    end
    jars.first
  end

  def amount_to_fill
    order_line.quantity / order_line.jars.count
  end

  ### Bag

  belongs_to :bag

  validates :bag, presence: true



  ### Order_line

  belongs_to :order_line

  has_one :order, through: :order_line



  ### Plants

  has_many :plants, -> { uniq }, through: :bag
  
  

  ### Lot

  has_many :lots, -> { uniq }, through: :bag

  has_many :strains, -> { uniq }, through: :plants

  has_many :containers, -> { uniq }, through: :bag 

  has_many :brands, -> { uniq }, through: :strains

  delegate :category, to: :container, prefix: false, allow_nil: true



  def unfulfilled?
    !fulfilled?
  end



  ### Utils

  def to_s
    "JAR#{id}"
  end

  def lot
    lots.first
  rescue
    ''
  end

  def strain
    strains.first
  rescue
    ''
  end

  def plant
    plants.first
  rescue
    ''
  end

  def brand
    brands.first
  rescue
    ''
  end

  def container
    containers.first
  rescue
    ''
  end

end