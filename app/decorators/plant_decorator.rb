class PlantDecorator < ApplicationDecorator
  
  decorates :plant

  delegate_all

  def actions
  end

end
