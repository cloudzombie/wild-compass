class Plant < ActiveRecord::Base

  ##########################
  ### Plant              ###
  ##########################
  ### cultivar: Cultivar ###
  ### format:   Format   ###
  ### status:   Status   ###
  ### rfid:     Rfid     ###
  ### lot:      Lot      ###
  ##########################

  include Accountable
  
  before_create :create_history
  before_save :create_history, unless: :history_exists?

  ### History

  belongs_to :history

  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid

  belongs_to :lot

  def increase_current_weight(quantity) #Increase plant weight.
    update_attributes current_weight: current_weight + quantity
  end

  def decrease_current_weight(quantity) #Increase lot weight.
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