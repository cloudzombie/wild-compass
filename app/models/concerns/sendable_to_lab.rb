module SendableToLab
  extend ActiveSupport::Concern
  
  def send_to_lab(user)
    if !sent_to_lab
      history.add_line(self, self, nil, :send_to_lab, user, "Sent to lab by #{user}.")
      status.update(sent_to_lab: true)
    else
      history.add_line(self, self, nil, :send_to_lab, user, "Received from lab by #{user}.")
      status.update(sent_to_lab: false)
    end
  end

end