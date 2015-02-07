class ChangeOriginToPlantId < ActiveRecord::Migration
  def change
    add_column :plants, :plant_id, :integer
  end
end
