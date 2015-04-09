class BagDecorator < ApplicationDecorator

  decorates :bag

  delegate_all

  def actions
  end

end
