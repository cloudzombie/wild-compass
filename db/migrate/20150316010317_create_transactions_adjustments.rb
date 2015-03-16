class CreateTransactionsAdjustments < ActiveRecord::Migration
  def change
    create_table :transactions_adjustments do |t|

      t.timestamps
    end
  end
end
