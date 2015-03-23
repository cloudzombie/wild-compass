class Transactions::Harvest < ActiveRecord::Base

  def self.instance
    first || Transactions::Harvest.create
  end

  has_many :outgoing_transactions, class_name: 'Transaction', as: 'source'

  def transactions
    outgoing_transactions
  end

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
