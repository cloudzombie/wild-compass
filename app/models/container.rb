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



  def water_loss
    loss = incoming_weight - outgoing_weight - bagged_weight
    # update(water_loss: loss) if self[:water_loss] != loss
    # self[:water_loss]
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

  

  ### Containers

  # Dat finest piece of design #trololol #softeng

  def incoming_transactions
    Transaction.where('target_id = ? AND target_type = ?', id, self.class)
  end

  def outgoing_transactions
    Transaction.where('source_id = ? AND source_type = ?', id, self.class)
  end

  has_many :incoming_transactions, as: 'source', dependent: :destroy

  has_many :outgoing_transactions, as: 'target', dependent: :destroy

  def transactions
    Transaction.where('(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)', id, self.class, id, self.class)
  end



  def current_weight
    weight = incoming_weight - outgoing_weight - bagged_weight - water_loss
    # update(current_weight: weight) if self[:current_weight] != weight
    # self[:current_weight]
  end

  def initial_weight
    weight = incoming_transactions.order(event: :asc).first.weight unless incoming_transactions.empty?
    # update(initial_weight: weight) if self[:initial_weight] != weight
    # self[:initial_weight]
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
