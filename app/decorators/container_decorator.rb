class ContainerDecorator < ApplicationDecorator

  decorates :container

  delegate_all

  def actions
  end

end
