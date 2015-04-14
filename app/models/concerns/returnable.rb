module Returnable
  extend ActiveSupport::Concern

  def perform_return(user)
    history.add_line(self, self, nil, :return, user, "Jar returned to inventory by #{user}.")
    update_attributes!(returned: true)
    true
  rescue ActiveRecord::RecordInvalid => e
    Raven.capture_exception(e)
    false
  end
  
end