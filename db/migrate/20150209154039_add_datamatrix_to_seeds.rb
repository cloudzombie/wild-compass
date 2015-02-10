class AddDatamatrixToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :datamatrix_text, :string
    add_column :seeds, :datamatrix_hash, :string
    add_index( :seeds, [ :datamatrix_text, :datamatrix_hash ], unique: true )
  end
end
