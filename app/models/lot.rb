class Lot < ActiveRecord::Base

  ########################
  ### Lot              ###
  ########################
  ### history: History ###
  ### plants:  Plant   ###
  ### bags:    Bag     ###
  ### weight:  integer ###
  ########################



  ### History

  belongs_to :history



  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags



  ### Weight

  validates :weight, presence: true, numericality: { greater_than: 0 }



  def to_s
    "#{ name.upcase unless name.nil? }"
  end
end
