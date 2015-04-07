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

  after_create :update_name, unless: :has_name?

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

  scope :available,     -> { where(current_weight: 0..Float::INFINITY, sent_to_lab: false, tested: false, archived: false) }



  def self.first_available
    by_buds.available.first
  end



  belongs_to :lot

  has_many :plants,  -> { uniq }, through: :lot



  belongs_to :bin

  belongs_to :status, class_name: 'Bags::Status', foreign_key: 'bags_status_id'

  

  has_many :strains, -> { uniq }, through: :plants

  has_many :brands,  -> { uniq }, through: :strains

  

  delegate :category, to: :container, prefix: false, allow_nil: true

  has_one :location, through: :bin
  
  def destruction(user)
    if !is_destroyed
      history.add_line(self, self, nil, :destruction, user, "Destroyed by #{user} from #{bin}.")
      update(is_destroyed: true, bin: nil)
    else
      history.add_line(self, self, nil, :destruction, user, "Restored by #{user}.")
      update(is_destroyed: false)
    end
  end

  def send_to_lab(user)
    if !sent_to_lab
      history.add_line(self, self, nil, :send_to_lab, user, "Sent to lab by #{user}.")
      update(sent_to_lab: true)
    else
      history.add_line(self, self, nil, :send_to_lab, user, "Received from lab by #{user}.")
      update(sent_to_lab: false)
    end
  end

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

    def update_name
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
