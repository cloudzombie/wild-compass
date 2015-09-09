class Account::Transaction < ActiveRecord::Base
  belongs_to :credit, class_name: 'Account', foreign_key: 'credit_account_id'
  belongs_to :debit,  class_name: 'Account', foreign_key: 'debit_account_id'

  validates :value, presence: true

  after_save -> { [credit, debit].each { |a| a.transaction_changed }}
end
