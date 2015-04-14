class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable
  include Sortable
  include Filterable
  include Returnable
  include SendableToLab
  include Destroyable

  include Wild::Compass::Model::Jar::HasJarStatus
  include Wild::Compass::Model::Location::HasLocationThroughBin



  scope :id,            -> (id = nil) { id.nil? ? all : where(id: id) }
  scope :strain_id,     -> (strain_id = nil) { strain_id.nil? ? all : where(strain_id: strain_id) }
  scope :status_id,     -> (status_id = nil) { status_id.nil? ? all : where(status_id: status_id) }
  scope :format_id,     -> (format_id = nil) { format_id.nil? ? all : where(format_id: format_id) }
  scope :type,          -> (type = nil) { type.nil? ? all : where(type: type) }

  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  scope :fulfilled,     -> { uniq.where fulfilled: true  } 
  scope :unfulfilled,   -> { uniq.where fulfilled: false }



  def next
    unfulfilled_jars = []
    
    order_line.jars.order(id: :asc).each do |jar|
      next if jar == self
      unfulfilled_jars << jar if jar.unfulfilled?
    end

    unfulfilled_jars.first
  end



  def amount_to_fill
    order_line.quantity / order_line.jars.count
  rescue ZeroDivisionError => e
    Raven.capture_exception(e)
    0.0
  end



  def bag
    bags.first
  end


  ### Order_line

  belongs_to :order_line

  has_one :order, through: :order_line



  ### Plants

  has_many :plants, -> { uniq }, through: :lots
  
  has_many :strains, -> { uniq }, through: :plants

  has_many :brands, -> { uniq }, through: :strains



  ### Lot

  has_many :lots, -> { uniq }, through: :incoming_bags

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