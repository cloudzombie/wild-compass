class Waste < ActiveRecord::Base

  has_many :incoming_transactions, as: 'source'

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def to_s
    'Waste'
  end

  alias_method :name, :to_s

  def transaction_changed
  end
end
