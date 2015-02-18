class Harvest < ActiveRecord::Base

  has_many :outgoing_transactions, as: 'target'

  def outgoing_weight
    outgoing_transactions.sum(:weight)
  end

  def to_s
    'Harvest'
  end

  alias_method :name, :to_s

  def transaction_changed
  end
end
