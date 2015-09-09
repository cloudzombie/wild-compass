class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :debit_account_id,  null: false
      t.integer :credit_account_id, null: false

      t.decimal :value, null: false, default: 0.0

      t.timestamps null: false
    end

    add_index :account_transactions, :debit_account_id
    add_index :account_transactions, :credit_account_id
  end
end
