class AddShippedDateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shippedDate, :timestamp
  end
end
