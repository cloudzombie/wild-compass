class Container < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Sortable



  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { where(category: category).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }  
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  def transaction_changed
    inc = incoming_weight
    out = outgoing_weight
    bag = bagged_weight
    wat = inc - out - bag

    initial = 0.0
    begin
      initial = incoming_transactions.order(event: :asc).first.weight
    rescue
      initial = 0.0
    end

    update(water_loss: wat)
    update(current_weight: 0)
    update(initial_weight: initial)
  end

  def bagged_weight
    bags.sum(:initial_weight)
  end

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def outgoing_weight
    outgoing_transactions.sum(:weight)
  end

  ### Transactions

  has_many :incoming_transactions, as: 'target', class_name: 'Transaction', dependent: :destroy

  has_many :outgoing_transactions, as: 'source', class_name: 'Transaction', dependent: :destroy

  def transactions
    Transaction.where('(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)', id, self.class, id, self.class)
  end



  ### Plants

  has_and_belongs_to_many :plants, -> { uniq }

  accepts_nested_attributes_for :plants

  def plant
    plants.first
  rescue
    ''
  end



  ### Lots

  has_and_belongs_to_many :lots, -> { uniq }

  def lot
    lots.first
  rescue
    ''
  end



  ### Bags

  has_many :bags

  def bag
    bags.first
  rescue
    ''
  end



  ### Jars

  has_many :jars, through: :bags

  def jar
    jars.first
  rescue
    ''
  end



  ### Strains

  has_many :strains, -> { uniq }, through: :plants

  def strain
    strains.first
  rescue
    ''
  end



  ### Brands

  has_many :brands,  -> { uniq }, through: :strains



  ### Locations

  belongs_to :location



  ### Utils

  def to_s
    "#{ name.try(:upcase).sub('CONTAINER','CTN') }"
  rescue
    ''
  end  

end
