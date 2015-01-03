class Bag < ActiveRecord::Base

  include Weightable
  include Accountable

  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }
  scope :strains, -> (strain = nil) { joins(:lot).merge(Lot.where(strain: strain)) }



  ### History

  belongs_to :history
  before_create :create_history
  before_save :create_history, unless: :history_exists?



  ### Lot

  belongs_to :lot



  ### Jars

  has_many :jars



  ### Plants

  has_many :plants, through: :lot

  has_many :strains, through: :plants

  has_one :category, through: :lot
  


  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    def create_history 
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end

end
