require 'csv'

class Lot < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Quarantineable
  include Recallable
  include Sortable
  include Filterable

  def timeline_transactions
    txn = []

    bags.each do |b|
      b.timeline_transactions.each do |t|
        txn << t
      end
    end

    txn.uniq
  end
  
  def self.to_csv
    CSV.generate { |csv|
      csv << [ 'Lot ID', 'Plant ID' ]
      all.each { |lot|
        lot.plants.each do |plant|
          csv << [ lot.id, plant.id ]
        end
      }
    }
  end

  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)).uniq }
  scope :by_categories, -> (category = nil) { joins(:containers).merge(Container.where(category: category)).uniq }
  scope :by_trims,      -> { by_categories 'Trim' }
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)).uniq }

  

  has_many :strains, -> { uniq }, through: :plants

  has_and_belongs_to_many :containers, -> { uniq }

  accepts_nested_attributes_for :containers

  

  has_and_belongs_to_many :plants, -> { uniq }
  
  has_many :bags



  has_many :jars, -> { uniq }, through: :bags

  # delegate :category, to: :container, prefix: false, allow_nil: true

  #has_many :brands, -> { uniq }, through: :strains

  belongs_to :brand


  def bag_changed
    update(current_weight: bags.sum(:current_weight))
  end

#  def brand
#    brands.first
#  end



  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  def container
    containers.first
  rescue
    ''
  end

  def plant
    plants.first
  rescue
    ''
  end

  def bag
    bags.first
  rescue
    ''
  end

  def jar
    jars.first
  rescue
    ''
  end

  def strain
    strains.first
  rescue
    ''
  end

end
