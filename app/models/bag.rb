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
  include SendableToLab
  include Destroyable

  include Wild::Compass::Model::Bag::HasBagStatus
  include Wild::Compass::Model::Location::HasLocationThroughBin

  after_create :set_name

  after_save -> { lot.bag_changed unless lot.nil? }

  scope :by_strains,    -> (strain = nil) { joins(:plants).merge(Plant.where(strain: strain)) }
  scope :by_categories, -> (category = nil) { joins(:container).merge(Container.where(category: category)) }
  scope :by_trims,      -> { by_categories 'Trim' }
  scope :by_buds,       -> { by_categories 'Buds' }
  scope :by_brands,     -> (brand = nil) { joins(:strains).merge(Strain.where(brand: brand)) }

  scope :fulfilled,     -> { uniq.joins(:outgoing_jars).merge( Jar.fulfilled   )}
  scope :unfulfilled,   -> { uniq.joins(:outgoing_jars).merge( Jar.unfulfilled )}

  scope :tested,        -> { where tested: true }
  scope :archived,      -> { where archived: true }


  belongs_to :lot  

  has_many :plants,  -> { uniq }, through: :lot

  

  has_many :strains, -> { uniq }, through: :plants

  has_many :brands,  -> { uniq }, through: :strains

  

  delegate :category, to: :container, prefix: false, allow_nil: true


  has_one :location, through: :bin

  add_filters_for :strains, :sent_to_lab, :is_destroyed, :location, :bin_id, :lot_id, :delta, :current_weight, :inital_weight, :status, :created_at, :updated_at
  

  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  def strain
    strains.first
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
      update_attributes!(name: "BAG-#{id}")
      true
    rescue ActiveRecord::RecordInvalid => e
      Raven.capture_exception(e)
      false
    end

    def update_category
      update_attributes!(category: category.titleize)
      true
    rescue NoMethodError, ActiveRecord::RecordInvalid => e
      Raven.capture_exception(e)
      false
    end

    def update_strain
      update_attributes!(strain: strain.acronym.upcase)
      true
    rescue NoMethodError, ActiveRecord::RecordInvalid => e
      Raven.capture_exception(e)
      false
    end

end
