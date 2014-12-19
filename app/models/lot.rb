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



  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags



  ### Weight

  validates :current_weight, presence: true, numericality: { greater_than: 0 }
  validates :initial_weight, presence: true, numericality: { greater_than: 0 }



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
