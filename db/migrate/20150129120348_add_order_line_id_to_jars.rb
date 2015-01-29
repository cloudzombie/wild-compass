class AddOrderLineIdToJars < ActiveRecord::Migration
  def change
    add_column :jars, :order_line_id, :integer
    remove_column :order_lines, :jar_id, :integer
  end
end
