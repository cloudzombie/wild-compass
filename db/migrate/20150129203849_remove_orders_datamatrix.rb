class RemoveOrdersDatamatrix < ActiveRecord::Migration
  def change
    remove_column :orders, :datamatrix_text, :string
    remove_column :orders, :datamatrix_hash, :string
  end
end
