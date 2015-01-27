class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Labelizable
  

  scope :by_strains,       -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories,    -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,         -> { by_categories 'Trim' }
  scope :by_buds,          -> { by_categories 'Buds' }
  scope :by_brands,        -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }


  belongs_to :lot

  has_many :jars, -> { uniq }

  has_many :plants, -> { uniq }, through: :lot

  has_many :containers, -> { uniq }, through: :lot

  has_many :strains, -> { uniq }, through: :plants

  belongs_to :bin

  delegate :category, to: :container, prefix: false, allow_nil: true



  ### Datamatrix

  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode self.try(:id) }").read
  end



  def encode(id)
    text = "BAG-#{id}"
    hash = Digest::MD5.hexdigest(text)
    update datamatrix_text: text, datamatrix_hash: hash
    hash
  end

  def get_origins
    origins_array = Array.new
    origins_array << [self, self.container, self.lot, self.lot.plants]
  end
  
  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  def strain
    strains.first
  rescue
    ''
  end

  def jar
    jars.first
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
