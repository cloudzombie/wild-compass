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

  before_create :create_history
  before_save :create_history, unless: :history_exists?

  ### History

  belongs_to :history



  ### Bag

  belongs_to :bag



  ### Plants

  has_many :plants, through: :bag



  ### Lot

  def lot
    bag.lot
  end

  def lot=(lot)
    bag.lot = lot
  end



  ### Utils

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  private

    def create_history
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end

end