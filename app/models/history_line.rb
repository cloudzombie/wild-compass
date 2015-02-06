class HistoryLine < ActiveRecord::Base
    
  #########################
  ### HistoryLine       ###
  #########################
  ### quantity: integer ###
  ### history:  History ###
  ### source:   poly    ###
  ### target:   poly    ###
  #########################


  ### Quantity

  validates :quantity, presence: true, numericality: { greater_than: 0.0 }



  ### History

  belongs_to :history



  belongs_to :user




  ### Source

  belongs_to :source, polymorphic: true



  ### Target

  belongs_to :target, polymorphic: true
  
end
