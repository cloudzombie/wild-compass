class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }



  ### Bag

  belongs_to :bag

  validates :bag, presence: true



  ### Order_line

  belongs_to :order_line



  ### Plants

  has_many :plants, -> { uniq }, through: :bag
  
  

  ### Lot

  has_many :lots, -> { uniq }, through: :bag

  has_many :strains, -> { uniq }, through: :plants

  has_many :containers, -> { uniq }, through: :bag 

  delegate :category, to: :container, prefix: false, allow_nil: true



  ### Datamatrix

  def datamatrix
    Datamatrix.new self.try(:id)
  rescue
    Rails.logger.log "COULD NOT CREATE DATAMATRIX FOR JAR WITH ID : #{ self.try(:id) }"
  end



  ### Utils

  def to_s
    "#{ name.upcase unless name.nil? }"
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

  def container
    containers.first
  rescue
    ''
  end

end