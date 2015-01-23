class AddDatamatrixTextAndHashToBags < ActiveRecord::Migration
  def change
    add_column :bags, :datamatrix_text, :string
    add_column :bags, :datamatrix_hash, :string
  end
end
