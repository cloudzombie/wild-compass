class AddDatamatrixToBins < ActiveRecord::Migration
  def change
    add_column :bins, :datamatrix_hash, :string
    add_column :bins, :datamatrix_text, :string
    add_index( :bins, [ :datamatrix_text, :datamatrix_hash ], unique: true )
  end
end
