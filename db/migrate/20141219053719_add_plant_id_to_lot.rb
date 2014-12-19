class AddPlantIdToLot < ActiveRecord::Migration
  def change
    add_column :lots, :plant_id, :int
  end
end
