class HistoryLine < ActiveRecord::Base
    
  #########################
  ### HistoryLine       ###
  #########################
  ### quantity: integer ###
  ### history:  History ###
  ### source:   poly    ###
  ### target:   poly    ###
  #########################



  scope :reweight, -> { where(event: 'reweight') }



  ### Quantity

  validates :quantity, presence: true



  ### History

  belongs_to :history



  belongs_to :user




  ### Source

  belongs_to :source, polymorphic: true



  ### Target

  belongs_to :target, polymorphic: true
  
end
