class AddDatamatrixToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :datamatrix_hash, :string
    add_column :plants, :datamatrix_text, :string
    add_index( :plants, [ :datamatrix_text, :datamatrix_hash ], unique: true )
  end
end
