class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Sortable
  include Encodable


  scope :by_strains,  -> (strain = nil) { where(strain: strain) }
  scope :by_brands,   -> (brand = nil) { where(brand: brand) }
  
  scope :filter, -> (args) {
    strain_filter = args[:strain_filter]
    status_filter = args[:status_filter]
    format_filter = args[:format_filter]
    if strain_filter && status_filter && format_filter
      where(strain_id: strain_filter, status_id: status_filter, format_id: format_filter)
    elsif strain_filter && status_filter
      where(strain_id: strain_filter, status_id: status_filter)
    elsif strain_filter && format_filter
      where(strain_id: strain_filter, format_id: format_filter)
    elsif status_filter && format_filter
      where(status_id: status_filter, format_id: format_filter)
    elsif status_filter
      where(status_id: status_filter)
    elsif strain_filter
      where(strain_id: strain_filter)
    elsif format_filter
      where(format_id: format_filter)
    else
      all
    end
  }

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