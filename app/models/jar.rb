class Jar < ActiveRecord::Base

  include Weightable
  include Accountable

  

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

  def lot
    bag.lot
  end

  def lot=(lot)
    bag.lot = lot
  end



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