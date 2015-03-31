class Plant < ActiveRecord::Base

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

  has_and_belongs_to_many :lots, -> { uniq }

  belongs_to :harvest

  belongs_to :plant

  belongs_to :seed

  belongs_to :location
  
  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid

  has_one :brand, through: :strain



  def to_s
    "Plant-#{id}".upcase
  end

end