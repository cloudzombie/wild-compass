class ChangeOriginToPlantId < ActiveRecord::Migration
  def change
    rename_column :plants, :origin, :plant_id
  end
end
