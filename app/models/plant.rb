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



  def transaction_changed
  end

  ### Transactions

  has_many :incoming_transactions, as: 'target', class_name: 'Transaction', dependent: :destroy

  has_many :outgoing_transactions, as: 'source', class_name: 'Transaction', dependent: :destroy

  def transactions
    Transaction.where('(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)', id, self.class, id, self.class)
  end



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

  before_save :record_change, if: :changed?

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

  private

    def record_change
      history.add_line(self, self, 0.0, :change, nil, "#{changed_attributes}")
      true
    end

end