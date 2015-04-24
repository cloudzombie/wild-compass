class ContainerDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :container

  delegate_all

end
