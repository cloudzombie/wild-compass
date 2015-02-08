class AddOrderedAmountToJars < ActiveRecord::Migration
  def change
    add_column :jars, :ordered_amount, :decimal, precision: 16, scale: 4, null: false, default: 0.0
  end
end
