class Jar < ActiveRecord::Base

  ###############################
  ### Jar                     ###
  ###############################
  ### history: History        ###
  ### bag:     Bag            ###
  ### plants:  Plant          ###
  ### lot:     Lot            ###
  ### initial_weight: integer ###
  ### current_weight: integer ###
  ###############################

  

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


  ### Weight

  def increase_current_weight(quantity)
    update_attributes current_weight: current_weight + quantity
  end

  def decrease_current_weight(quantity)
    update_attributes current_weight: current_weight - quantity
  end

  validates :current_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }



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