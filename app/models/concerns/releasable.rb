module Releasable
  extend ActiveSupport::Concern

  def release(user)
    update(released: true)
    history.add_line(self, self, nil, :release, user, "Lot released for sale by #{user}.")
  end

  def unrelease(user)
    update(released: false)
    history.add_line(self, self, nil, :unrelease, user, "Lot unreleased for sale by #{user}.")
  end
  
end