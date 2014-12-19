class History < ActiveRecord::Base

  ##################################
  ### History                    ###
  ##################################
  ### history_lines: HistoryLine ###
  ##################################

  def add_line(source, target, quantity, event)
    history_lines << HistoryLine.create(source: source, target: target, quantity: quantity)
  end



  ### History lines

  has_many :history_lines

end
