class JarDecorator < ApplicationDecorator

  decorates :jar

  delegate_all

  def actions
  end

end
