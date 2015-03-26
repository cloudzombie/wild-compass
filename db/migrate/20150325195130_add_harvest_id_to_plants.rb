class AddHarvestIdToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :harvest_id, :integer
  end
end
