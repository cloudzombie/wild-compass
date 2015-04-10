class ContainerDecorator < ApplicationDecorator

  decorates :container

  delegate_all

end
