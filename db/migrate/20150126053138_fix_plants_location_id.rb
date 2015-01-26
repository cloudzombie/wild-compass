class FixPlantsLocationId < ActiveRecord::Migration
  def change
    rename_column :plants, :location, :location_id
  end
end
