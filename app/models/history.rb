class History < ActiveRecord::Base

  ##################################
  ### History                    ###
  ##################################
  ### historiable:   poly        ###
  ### history_lines: HistoryLine ###
  ##################################



  ### Historiable

  belongs_to :historiable, polymorphic: true



  ### History lines

  has_many :history_lines

end
