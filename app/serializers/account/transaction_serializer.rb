class Account::TransactionSerializer < ActiveModel::Serializer
  attributes :id, :debit, :credit, :value
end
