class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  scope :fulfilled,   -> { joins(:order_line).merge(OrderLine.joins(:jars).merge(Jar.where(fulfilled: true  ).order(id: :asc))).uniq }
  scope :unfulfilled, -> { joins(:order_line).merge(OrderLine.joins(:jars).merge(Jar.where(fulfilled: false ).order(id: :asc))).uniq }



  def next
    jars = []
    order_line.jars.order(id: :asc).each do |jar|
      next if jar == self
      jars << jar if jar.unfulfilled?
    end
    jars.first
  end

  after_create :set_ordered_amount, unless: :has_ordered_amount?

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

  private

    def set_ordered_amount
      update(ordered_amount: amount_to_fill)
    end

    def has_ordered_amount?
      ordered_amount > 0.0
    end

end