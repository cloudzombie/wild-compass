class LotDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :lot

  delegate_all

end
