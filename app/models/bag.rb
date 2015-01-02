class Bag < ActiveRecord::Base

  #######################
  ### Bag             ###
  #######################
  ### lot:    Lot     ###
  ### jars:   Jar[]   ###
  ### plants: Plant[] ###
  ### weight: int     ###
  #######################

  include Accountable

  attr_accessor :weight



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



  ### Weight

  #Increase bag weight.
  def increase_current_weight(quantity)
    update_attributes current_weight: current_weight + quantity #Add quantity to current_weight
  end

  #Decrease bag weight.
  def decrease_current_weight(quantity)
    update_attributes current_weight: current_weight - quantity #Substract quantity to current_weight
  end

  validates :current_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :weight, presence: false, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  


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
