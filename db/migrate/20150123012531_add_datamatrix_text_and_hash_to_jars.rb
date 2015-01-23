class AddDatamatrixTextAndHashToJars < ActiveRecord::Migration
  def change
    add_column :jars, :datamatrix_text, :string
    add_column :jars, :datamatrix_hash, :string
  end
end
