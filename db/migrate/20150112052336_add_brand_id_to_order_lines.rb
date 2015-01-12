class AddBrandIdToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :brand_id, :integer
  end
end
