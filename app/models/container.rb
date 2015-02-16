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
    bagged_dry_weight = 0.0
    
    if bags.present?
      bags.each do |b|
        bagged_dry_weight += (b.initial_weight.nil? ? 0.0 : b.initial_weight)
      end
    end

    incoming_weight = 0.0
    incoming_transactions.each do |transaction|
      incoming_weight += (transaction.weight.nil? ? 0.0 : transaction.weight)
    end

    outgoing_weight = 0.0
    outgoing_transactions.each do |transaction|
      outgoing_weight += (transaction.weight.nil? ? 0.0 : transaction.weight)
    end

    water_loss = ( incoming_weight - outgoing_weight ) - bagged_dry_weight
    return water_loss if water_loss > 0.0
    0.0
  end

  

  ### Containers

  # Dat finest piece of design #trololol #softeng

  def incoming_transactions
    Transaction.where('target_id = ? AND target_type = ?', id, self.class)
  end

  def outgoing_transactions
    Transaction.where('source_id = ? AND source_type = ?', id, self.class)
  end

  def transactions
    Transaction.where('(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)', id, self.class, id, self.class)
  end



  def current_weight
    bagged_dry_weight = 0.0
    
    if bags.present?
      bags.each do |b|
        bagged_dry_weight += (b.initial_weight.nil? ? 0.0 : b.initial_weight)
      end
    end

    incoming_weight = 0.0
    incoming_transactions.each do |transaction|
      incoming_weight += (transaction.weight.nil? ? 0.0 : transaction.weight)
    end

    outgoing_weight = 0.0
    outgoing_transactions.each do |transaction|
      outgoing_weight += (transaction.weight.nil? ? 0.0 : transaction.weight)
    end

    ( incoming_weight - outgoing_weight ) - bagged_dry_weight
  end

  def initial_weight
    return incoming_transactions.order(event: :asc).first.weight unless incoming_transactions.empty?
    0.0
  rescue
    0.0
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
