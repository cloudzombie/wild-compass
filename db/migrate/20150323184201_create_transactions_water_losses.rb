class CreateTransactionsWaterLosses < ActiveRecord::Migration
  def change
    create_table :transactions_water_losses do |t|

      t.timestamps
    end
  end
end
