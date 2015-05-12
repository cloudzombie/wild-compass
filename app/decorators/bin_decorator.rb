class BinDecorator < ApplicationDecorator

  decorates :bin

  delegate_all

end
