class RemoveProductTypeAndIdFromOrderLines < ActiveRecord::Migration
  def change
    remove_column :order_lines, :product_type, :string
    remove_column :order_lines, :product_id, :integer
  end
end
