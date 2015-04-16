class BagDecorator < ApplicationDecorator

  decorates :bag

  delegate_all

end
