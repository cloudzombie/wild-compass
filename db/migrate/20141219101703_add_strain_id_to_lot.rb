class AddStrainIdToLot < ActiveRecord::Migration
  def change
    add_column :lots, :strain_id, :int
  end
end
