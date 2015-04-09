class LotDecorator < ApplicationDecorator

  decorates :lot

  delegate_all

  def actions
  end

end
