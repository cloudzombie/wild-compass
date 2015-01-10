class Jar < ActiveRecord::Base

  include Weightable
  include Accountable

  scope :strains, -> (strain = nil) { joins(:lot).merge(Lot.where(strain: strain)) }
  scope :categories, -> (category = nil) { joins(:lot).merge(Lot.where(category: category)) }
  scope :trims,   -> { joins(:lot).merge(Lot.where(category: 'Trim')) }  
  scope :buds,    -> { joins(:lot).merge(Lot.where(category: 'Buds')) }



  ### History

  belongs_to :history
  before_create :create_history
  before_save :create_history, unless: :history_exists?



  ### Bag

  belongs_to :bag

  validates :bag, presence: true



  ### Order_line

  belongs_to :order_line



  ### Plants

  has_many :plants, through: :bag
  
  

  ### Lot

  has_one :lot, through: :bag

  has_one :strain, through: :bag

  has_one :category, through: :bag



  ### Datamatrix

  def datamatrix
    Datamatrix.new(id)
  end



  ### Utils

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