class Transactions::Adjustment < ActiveRecord::Base

  def self.instance
    first || Transactions::Adjustment.create
  end

  has_many :incoming_transactions, class_name: 'Transaction', as: 'target'

  def transactions
    incoming_transactions
  end

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def to_s
    'Adjustment'
  end

  alias_method :name, :to_s

  def transaction_changed
  end

end
