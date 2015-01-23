class AddDatamatrixTextAndHashToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :datamatrix_text, :string
    add_column :orders, :datamatrix_hash, :string
  end
end
