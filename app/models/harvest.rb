class Harvest < ActiveRecord::Base
  def to_s
    'Harvest'
  end

  alias_method :name, :to_s

  def transaction_changed
  end
end
