require "wild/compass/decorator/story"

class PlantDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :plant

  delegate_all

end
