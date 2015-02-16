class AddHarvestedAtToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :harvested_at, :datetime
  end
end
