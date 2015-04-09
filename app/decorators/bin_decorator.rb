class BinDecorator < ApplicationDecorator

  decorates :bin

  delegate_all

  def actions
  end

end
