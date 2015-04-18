require "wild/compass/decorator/story"

class BagDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :bag
  
  delegate_all  

end
