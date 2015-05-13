class LocationDecorator < ApplicationDecorator
  
  decorates :location

  delegate_all

end
