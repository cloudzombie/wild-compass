class AddJarIdToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :jar_id, :integer
  end
end
