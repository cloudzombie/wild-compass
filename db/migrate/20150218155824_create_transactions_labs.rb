class CreateTransactionsLabs < ActiveRecord::Migration
  def change
    create_table :transactions_labs do |t|

      t.timestamps
    end
  end
end
