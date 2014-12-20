class Bag < ActiveRecord::Base

  #######################
  ### Bag             ###
  #######################
  ### lot:    Lot     ###
  ### jars:   Jar[]   ###
  ### plants: Plant[] ###
  ### weight: int     ###
  #######################



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

  def increase_current_weight(quantity)
    update_attributes current_weight: current_weight + quantity
  end

  def decrease_current_weight(quantity)
    update_attributes current_weight: current_weight - quantity
  end

  validates :current_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :initial_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  


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
