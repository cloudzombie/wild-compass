require 'csv'

class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Sortable
  include Encodable
  include Filterable


  scope :by_strains,  -> (strain = nil) { where(strain: strain) }
  scope :by_brands,   -> (brand = nil) { where(brand: brand) }

  scope :id, -> (id = nil) { id.nil? ? all : where(id: id) }
  scope :strain_id, -> (strain_id = nil) { strain_id.nil? ? all : where(strain_id: strain_id) }
  scope :status_id, -> (status_id = nil) { status_id.nil? ? all : where(status_id: status_id) }
  scope :format_id, -> (format_id = nil) { format_id.nil? ? all : where(format_id: format_id) }
  scope :type, -> (type = nil) { type.nil? ? all : where(type: type) }


  def self.to_csv
    CSV.generate { |csv|
      csv << [ 'Plant ID', 'Lot ID' ]
      all.each { |plant|
        csv << [ plant.name, ( plant.lot.nil? ? nil : plant.lot.id ) ]
      }
    }
  end

  def transaction_changed
  end



  belongs_to :lot

  has_many :bags, -> { uniq }, through: :lot



  belongs_to :plant

  belongs_to :seed

  belongs_to :location
  
  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid



  has_and_belongs_to_many :containers, -> { uniq }

  accepts_nested_attributes_for :containers

  

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

  def jar
    jars.first
  rescue
    ''
  end

  private

end