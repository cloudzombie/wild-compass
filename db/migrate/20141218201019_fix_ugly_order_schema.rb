class FixUglyOrderSchema < ActiveRecord::Migration
  def change
    rename_column :orders, :orderDate, :ordered_at
    rename_column :orders, :shippedDate, :shipped_at
    remove_column :orders, :lastTimedUsed, :datetime
    remove_column :orders, :timestamp, :datetime
    remove_column :orders, :shipped, :integer
  end
end
