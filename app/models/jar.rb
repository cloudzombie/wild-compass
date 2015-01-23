require 'open-uri'
require 'digest'

class Jar < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,        -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }



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

  has_many :brands, -> { uniq }, through: :strains

  delegate :category, to: :container, prefix: false, allow_nil: true



  ### Datamatrix

  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode self.try(:id) }").read
  end

  def encode(id)
    text = "JAR-#{id}"
    hash = Digest::MD5.hexdigest(text)
    update datamatrix_text: text, datamatrix_hash: hash
    hash
  end



  ### Utils

  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    else
      self.all
    end
  end

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

  def container
    containers.first
  rescue
    ''
  end

end