class History < ActiveRecord::Base

  ##################################
  ### History                    ###
  ##################################
  ### history_lines: HistoryLine ###
  ##################################

  def add_line(source, target, quantity)
    history_lines << HistoryLine.create(source: source, target: target, quantity: quantity)
    save
  end



  ### History lines

  has_many :history_lines

end
