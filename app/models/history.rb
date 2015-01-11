class History < ActiveRecord::Base

  ##################################
  ### History                    ###
  ##################################
  ### history_lines: HistoryLine ###
  ##################################

  def add_line(source, target, quantity, event, user)
    history_lines << HistoryLine.create(source: source, target: target, quantity: quantity, event: event, user: user)
  end



  ### History lines

  has_many :history_lines

end
