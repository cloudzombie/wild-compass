class AddIndexesToDatamatrixHashesAndDatamatrixText < ActiveRecord::Migration
  def change
    add_index( :bags,   [ :datamatrix_text, :datamatrix_hash ], unique: true )
    add_index( :jars,   [ :datamatrix_text, :datamatrix_hash ], unique: true )
    add_index( :orders, [ :datamatrix_text, :datamatrix_hash ], unique: true )
  end
end
