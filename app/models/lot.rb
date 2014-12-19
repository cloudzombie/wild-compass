class Lot < ActiveRecord::Base

  ########################
  ### Lot              ###
  ########################
  ### history: History ###
  ### plants:  Plant   ###
  ### bags:    Bag     ###
  ### weight:  integer ###
  ########################

  before_create :create_history
  before_save :create_history, unless: :history_exists?

  ### History

  belongs_to :history

  ### Strain

  belongs_to :strain

  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags



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
