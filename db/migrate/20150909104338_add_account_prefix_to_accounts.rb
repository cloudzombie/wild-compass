class AddAccountPrefixToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.belongs_to :account_prefix
    end
  end
end
