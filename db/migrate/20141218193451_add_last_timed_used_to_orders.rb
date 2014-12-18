class AddLastTimedUsedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :lastTimedUsed, :timestamp
  end
end
