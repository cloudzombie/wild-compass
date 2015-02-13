class Waste < ActiveRecord::Base
  def to_s
    'Waste'
  end

  alias_method :name, :to_s
end
