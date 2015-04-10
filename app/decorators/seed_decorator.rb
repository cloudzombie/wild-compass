class SeedDecorator < ApplicationDecorator

  decorates :seed

  delegate_all

  def actions
  end

end
