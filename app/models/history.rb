class History < ActiveRecord::Base

  ##################################
  ### History                    ###
  ##################################
  ### history_lines: HistoryLine ###
  ##################################



  ### History lines

  has_many :history_lines, dependent: :destroy

  def add_line(source, target, quantity, event, user, message)
    history_lines << HistoryLine.create(
      source: source,
      target: target,
      quantity: quantity,
      event: event,
      user: user,
      message: message
    )
  end

end
