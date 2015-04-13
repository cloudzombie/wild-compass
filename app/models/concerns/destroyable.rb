module Destroyable
  extend ActiveSupport::Concern

  def destruction(user)
    if !is_destroyed
      history.add_line(self, self, nil, :destruction, user, "Destroyed by #{user} from #{bin}.")
      status.update(is_destroyed: true, bin: nil)
    else
      history.add_line(self, self, nil, :destruction, user, "Restored by #{user}.")
      status.update(is_destroyed: false)
    end
  end
end