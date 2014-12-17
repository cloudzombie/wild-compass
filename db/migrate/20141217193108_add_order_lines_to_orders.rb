class AddOrderLinesToOrders < ActiveRecord::Migration
  def change
    add_column :order_lines, :order_id, :integer
  end
end
