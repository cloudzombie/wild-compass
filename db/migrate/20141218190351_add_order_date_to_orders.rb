class AddOrderDateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :orderDate, :timestamp
  end
end
