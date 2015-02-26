class CreateTransactionsDestructions < ActiveRecord::Migration
  def change
    create_table :transactions_destructions do |t|

      t.timestamps
    end
  end
end
