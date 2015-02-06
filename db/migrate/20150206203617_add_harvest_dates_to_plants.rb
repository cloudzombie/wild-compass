class AddHarvestDatesToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :partial_harvest_at, :datetime
    add_column :plants, :complete_harvest_at, :datetime
  end
end
