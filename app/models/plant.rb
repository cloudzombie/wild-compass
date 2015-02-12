class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Sortable



  scope :by_strains,  -> (strain = nil) { where(strain: strain) }
  scope :by_brands,   -> (brand = nil) { where(brand: brand) }

  belongs_to :plant 

  belongs_to :seed

  belongs_to :location
  
  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid

  has_and_belongs_to_many :containers, -> { uniq }

  accepts_nested_attributes_for :containers

  has_many :lots, -> { uniq }, through: :containers

  has_many :bags, -> { uniq }, through: :containers

  has_many :jars, -> { uniq }, through: :containers

  has_one :brand, through: :strain

  def to_s
    "Plant-#{id}".upcase
  end

  alias_method :name, :to_s



  def container
    containers.first
  rescue
    ''
  end

  def bag
    bags.first
  rescue
      ''
  end

  def lot
    lots.first
  rescue
    ''
  end

  def jar
    jars.first
  rescue
    ''
  end

end