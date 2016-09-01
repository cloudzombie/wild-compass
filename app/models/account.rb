class Account < ActiveRecord::Base

  has_many :debits,
    class_name: 'Account::Transaction',
    foreign_key: 'debit_account_id'

  has_many :credits,
    class_name: 'Account::Transaction',
    foreign_key: 'credit_account_id'

  belongs_to :prefix,
    class_name: 'Account::Prefix',
    foreign_key: 'account_prefix_id'

  validates :number,
    presence: true,
    numericality: { greater_than: 0 }

  validates :value,
    presence: true

  def name
    "#{prefix}-#{number}"
  end

  alias_method :to_s, :name

  def transaction_changed
    update(value: debits.sum(:value) - credits.sum(:value))
  end

end
