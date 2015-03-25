class Bag < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable
  include Searchable
  include Encodable
  include Recallable
  include Quarantineable
  include Sortable
  include Filterable

  after_create :set_name, unless: :has_name?

  after_save -> { lot.bag_changed unless lot.nil? }

  before_save :update_category
  before_save :update_strain

  scope :by_strains,       -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories,    -> (category = nil) { joins(:container).merge(Container.where(category: category)) }
  scope :by_trims,         -> { by_categories 'Trim' }
  scope :by_buds,          -> { by_categories 'Buds' }
  scope :by_brands,        -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)) }

  scope :fulfilled,        -> { uniq.joins(:jars).merge( Jar.fulfilled   )}
  scope :unfulfilled,      -> { uniq.joins(:jars).merge( Jar.unfulfilled )}

  scope :tested,           -> { where tested: true }
  scope :archived,         -> { where archived: true }



  def self.first_available(brand, weight)
    by_brands(brand).by_buds.where(
      current_weight: weight..Float::INFINITY,
      sent_to_lab: false,
      tested: false,
      archived: false
    ).first
  end



  belongs_to :lot

  has_many :plants,  -> { uniq }, through: :lot



  belongs_to :container

  belongs_to :bin

  belongs_to :status, class_name: 'Bags::Status', foreign_key: 'bags_status_id'

  has_many :jars,    -> { uniq }

  

  has_many :strains, -> { uniq }, through: :plants

  has_many :brands,  -> { uniq }, through: :strains

  

  delegate :category, to: :container, prefix: false, allow_nil: true

  has_one :location, through: :bin
  


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

  def brand
    brands.first
  rescue
    ''
  end

  def category
    container.category
  rescue
    ''
  end

  private

    def set_name
      update(name: "BAG-#{id}")
    end

    def update_category
      self[:category] = category.titleize unless category.nil?
    end

    def update_strain
      self[:strain] = strain.acronym.upcase unless strain.nil?
    end

end
