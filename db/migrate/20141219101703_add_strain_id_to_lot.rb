class AddStrainIdToLot < ActiveRecord::Migration
  def change
    add_column :lots, :strain_id, :integer
  end
end
