class AddShippedAndTimestampToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipped, :integer
    add_column :orders, :timestamp, :datetime
  end
end
