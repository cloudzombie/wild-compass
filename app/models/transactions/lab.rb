class Transactions::Lab < ActiveRecord::Base

  def self.instance
    first || Transactions::Lab.create
  end

  has_many :incoming_transactions, class_name: 'Transaction', as: 'target'

  def transactions
    incoming_transactions
  end

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def to_s
    'To Lab'
  end

  alias_method :name, :to_s

  def transaction_changed
  end
end