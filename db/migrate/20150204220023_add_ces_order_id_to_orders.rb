class AddCesOrderIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ces_order_id, :integer
    add_index  :orders, :ces_order_id, unique: true
  end
end
