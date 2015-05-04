class JarDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :jar

  delegate_all

end
