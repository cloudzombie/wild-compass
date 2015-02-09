class AddPlantIdsToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :plant_ids, :integer
  end
end
